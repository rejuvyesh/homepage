-- File: Pandoc.hs
-- Copyright rejuvyesh <mail@rejuvyesh.com>, 2014
-- License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>
module Site.Pandoc
    ( pandocCompiler
    , pandocCompilerWithToc
    ) where

import           Data.List              (isInfixOf)
import           Hakyll                 hiding (pandocCompiler)
import           Text.Pandoc.Definition
import           Text.Pandoc.Generic
import           Text.Pandoc.Options

pandocReaderOptions :: ReaderOptions
pandocReaderOptions = def
                      {
                        readerSmart  = True
                      }

pandocWriterOptions :: WriterOptions
pandocWriterOptions = def
                      {
                        writerHtml5          = True
                      , writerHtmlQTags      = True
                      , writerSectionDivs    = True
                      , writerStandalone     = True
                      , writerHTMLMathMethod = MathJax ""
                      }

pandocWriterTocOptions :: WriterOptions
pandocWriterTocOptions = pandocWriterOptions
                         {
                           writerTableOfContents = True
                         , writerTemplate = "<div class=\"toc\"><p><strong>Contents</strong></p>$toc$</div>\n$body$"
                         }

pandocTransform :: Pandoc -> Pandoc
pandocTransform = bottomUp (map addAmazonAffiliate)

addAmazonAffiliate :: Inline -> Inline
addAmazonAffiliate (Link r (l, t)) | "?search" `isInfixOf` l = Link r (l++"&tag=rejuvyeshcom-20", t)
                                   | "amazon.com/" `isInfixOf` l && not ("?tag=" `isInfixOf` l) =
                                       Link r (l++"?tag=rejuvyeshcom-20", t)
addAmazonAffiliate x = x

pandocCompiler :: Compiler (Item String)
pandocCompiler = pandocCompilerWithTransform pandocReaderOptions
                 pandocWriterOptions
                 pandocTransform

pandocCompilerWithToc :: Compiler (Item String)
pandocCompilerWithToc = pandocCompilerWithTransform pandocReaderOptions
                        pandocWriterTocOptions
                        pandocTransform
