-- File: Meta.hs
-- Copyright rejuvyesh <mail@rejuvyesh.com>, 2014
-- License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>

module Site.Meta
    ( postContext
    , feedContext
    , defContext
    , removeIndexHtml
    , filterDrafts
    , filterDraftItems
    , niceRoute
    ) where

-------------------------------------------------------------------------------

import           Control.Monad   (filterM, liftM)
import           Data.Monoid     ((<>))
import           System.FilePath (takeBaseName)

-------------------------------------------------------------------------------
import           Hakyll
-------------------------------------------------------------------------------

-- Is it a draft? If yes, filter it
isNotDraft :: MonadMetadata m => Identifier -> m Bool
isNotDraft identifier = liftM
                        (/= Just "in progress")
                        (getMetadataField identifier "status")

filterDrafts :: MonadMetadata m => [Identifier] -> m [Identifier]
filterDrafts = filterM isNotDraft

filterDraftItems :: [Item a] -> Compiler [Item a]
filterDraftItems = filterM $ isNotDraft . itemIdentifier

-- replace url of the form foo/bar/index.html by foo/bar
removeIndexHtml :: Item String -> Compiler (Item String)
removeIndexHtml = return . fmap (withUrls removeIndexStr)
  where
    removeIndexStr :: String -> String
    removeIndexStr str@(x:xs) | str == "/index.html" = ""
                              | otherwise = x:removeIndexStr xs
    removeIndexStr [] = []

-- replace a foo/bar.md by foo/bar/index.html
-- this way the url looks like: foo/bar in most browsers
niceRoute :: String -> Routes
niceRoute prefix = customRoute $
                   \ident -> prefix
                             ++ (takeBaseName . toFilePath $ ident)
                             ++ "/index.html"

-- Default Context
defContext :: Context String
defContext =
  dateField "date" "%B %e, %Y"                    <>
  dateField "archiveyear" "%Y"                    <>
  modificationTimeField "lastmodified" "%d %b %Y" <>
  constField "author" "rejuvyesh"

-- Post Context
postContext :: Tags -> Context String
postContext tags =
  defContext <>
  tagsField "tags" tags

-- Rss feed context
feedContext :: Context String
feedContext = bodyField "description"
