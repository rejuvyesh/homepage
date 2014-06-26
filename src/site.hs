#!/usr/bin/env runhaskell

{-Thanks to jaspervdj: http://jaspervdj.be/ -}
--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
module Main where


--------------------------------------------------------------------------------
import           Data.Monoid     (mappend, mconcat)
import           Data.List       (isInfixOf)
import           Prelude         hiding (id)
import           System.FilePath (takeBaseName)
import qualified Text.Pandoc     as Pandoc


--------------------------------------------------------------------------------
import           Hakyll


--------------------------------------------------------------------------------
-- | Entry point
main :: IO ()
main = hakyllWith config $ do
         -- Static files
    match ("images/*" .||. "javascripts/*" .||. "favicon.ico" .||. "files/**" .||. "fonts/*") $ do
        route   idRoute
        compile copyFileCompiler

    -- Compress CSS
    match "css/*" $ do
        route idRoute
        compile compressCssCompiler


    -- Build tags
    tags <- buildTags "posts/*" (fromCapture "tags/*.html")

    -- Render each and every post
    match "posts/*" $ do
        route   $ niceRoute "posts/"
        compile $ pandocCompiler
          >>= saveSnapshot "content"
          >>= return . fmap demoteHeaders
          >>= loadAndApplyTemplate "templates/post.html" (postCtx tags)
          >>= loadAndApplyTemplate "templates/default.html" defaultContext
          >>= relativizeUrls
          >>= removeIndexHtml

    -- Post list
    create ["weblog.html"] $ do
         route $ niceRoute ""
         compile $ do
             list <- postList tags "posts/*" recentFirst
             makeItem ""
                >>= loadAndApplyTemplate "templates/posts.html"
                        (constField "title" "All Posts" `mappend`
                         constField "posts" list `mappend`
                         defaultContext)
                >>= loadAndApplyTemplate "templates/default.html"
                        (constField "title" "Whisperings into the Wire" `mappend`
                         constField "description" "Blog" `mappend`
                         defaultContext)
                >>= relativizeUrls
                >>= removeIndexHtml

    -- Post tags
    tagsRules tags $ \tag pattern -> do
         let title = "Posts tagged " ++ tag

        -- Copied from posts, need to refactor
         route $ niceRoute "tags/"
         compile $ do
             list <- postList tags pattern recentFirst
             makeItem ""
                >>= loadAndApplyTemplate "templates/posts.html"
                        (constField "title" title `mappend`
                         constField "posts" list `mappend`
                         defaultContext)
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls
                >>= removeIndexHtml

        -- Create RSS feed as well
         version "rss" $ do
             route   $ setExtension "xml"
             compile $ loadAllSnapshots pattern "content"
                >>= fmap (take 10) . recentFirst
                >>= renderAtom (feedConfiguration title) feedCtx

    -- Index
    match "index.html" $ do
        route idRoute
        compile $ do
            list <- postList tags "posts/*" $ fmap (take 3) . recentFirst
            let indexContext = constField "posts" list `mappend`
                               field "tags" (\_ -> renderTagList tags) `mappend`
                               defaultContext

            getResourceBody
                >>= applyAsTemplate indexContext
                >>= loadAndApplyTemplate "templates/default.html" indexContext
                >>= relativizeUrls
                >>= removeIndexHtml

    -- Read templates
    match "templates/*" . compile $ templateCompiler

    -- Render some static pages
    match (fromList pages) $ do
        route   $ niceRoute ""
        compile $ pandocCompilerWithTransform  defaultHakyllReaderOptions pandocOptions pandocTransform
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls
                >>= removeIndexHtml

    -- Render the 404 page, we don't relativize URL's here.
    match "404.html" $ do
        route idRoute
        compile $ pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" defaultContext

    -- Render the resume page
    match "resume.html" $ do
        route   $ niceRoute ""
        compile copyFileCompiler
                                
    -- Render RSS feed
    create ["rss.xml"] $ do
        route idRoute
        compile $ loadAllSnapshots "posts/*" "content"
                >>= fmap (take 10) . recentFirst
                >>= renderAtom (feedConfiguration "All posts") feedCtx


    where
    pages =
      [   "contact.md"
        , "404.md" 
        , "acads.md"
        , "aboutme.md"
        , "recommendations.md"
        , "episteme.md"
        , "book-reviews.md"
        , "clippings.md"
        ]


--------------------------------------------------------------------------------
postCtx :: Tags -> Context String
postCtx tags = mconcat
    [ modificationTimeField "mtime" "%U"
    , dateField "date" "%B %e, %Y"
    , tagsField "tags" tags
    , defaultContext
    ]


-------------------------------------------------------------------------------
-- replace a foo/bar.md by foo/bar/index.html
-- this way the url looks like: foo/bar in most browsers
niceRoute :: String -> Routes
niceRoute prefix = customRoute $
                   \ident -> prefix ++ (takeBaseName . toFilePath $ ident) ++ "/index.html"

-- replace url of the form foo/bar/index.html by foo/bar
removeIndexHtml :: Item String -> Compiler (Item String)
removeIndexHtml item = return $ fmap (withUrls removeIndexStr) item
  where
    removeIndexStr :: String -> String
    removeIndexStr str@(x:xs) | str == "/index.html" = ""
                              | otherwise = x:removeIndexStr xs
    removeIndexStr [] = []

--------------------------------------------------------------------------------
feedCtx :: Context String
feedCtx = mconcat
    [ bodyField "description"
    , defaultContext
    ]


--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration
    { deployCommand = "/usr/bin/cp -rf _site/* ../rejuvyesh.github.io/ && cd ../rejuvyesh.github.io/ && git add -A && git commit -m \"update\" && git push origin"
    }


feedConfiguration :: String -> FeedConfiguration
feedConfiguration title = FeedConfiguration
    { feedTitle       = "Rejuvyesh's Whisperings into the Wire - " ++ title
    , feedDescription = "Personal blog of Jayesh Kumar Gupta"
    , feedAuthorName  = "Jayesh Kumar Gupta"
    , feedAuthorEmail = "mail@rejuvyesh.com"
    , feedRoot        = "http://rejuvyesh.com"
    }

pandocOptions :: Pandoc.WriterOptions
pandocOptions = defaultHakyllWriterOptions
    { Pandoc.writerHtmlQTags = True
    , Pandoc.writerTableOfContents = True
    , Pandoc.writerSectionDivs = True
    , Pandoc.writerTemplate = "<div id=\"TOC\">$toc$</div>\n$body$"
    , Pandoc.writerStandalone = True
    , Pandoc.writerHTMLMathMethod = Pandoc.MathJax ""                                
    }

pandocTransform :: Pandoc.Pandoc -> Pandoc.Pandoc
pandocTransform = Pandoc.bottomUp (map addAmazonAffiliate)

addAmazonAffiliate :: Pandoc.Inline -> Pandoc.Inline
addAmazonAffiliate (Pandoc.Link r (l, t)) | "?search" `isInfixOf` l = Pandoc.Link r (l++"&tag=rejuvyeshcom-20", t)
                                          | "amazon.com/" `isInfixOf` l && not ("?tag=" `isInfixOf` l) = Pandoc.Link r (l++"?tag=rejuvyeshcom-20", t)
addAmazonAffiliate x = x
--------------------------------------------------------------------------------

postList :: Tags -> Pattern -> ([Item String] -> Compiler [Item String])
         -> Compiler String
postList tags pattern preprocess' = do
    postItemTpl <- loadBody "templates/postitem.html"
    posts       <- preprocess' =<< loadAll pattern
    applyTemplateList postItemTpl (postCtx tags) posts
