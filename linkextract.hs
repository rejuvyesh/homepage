#!/usr/bin/env runhaskell

{- Thanks to Gwern@gwern.net
find . -name "*.md" -type f -print0 | xargs -0 runhaskell linkextract.hs >> ~/.urls
-}

import System.Environment (getArgs)
import Text.Pandoc

main :: IO ()
main = getArgs >>= mapM readFile >>= mapM_ analyzePage

analyzePage :: String -> IO Pandoc
analyzePage x = bottomUpM printLinks (readMarkdown def (unlines . drop 1 . lines $ x))

printLinks :: Inline -> IO Inline
printLinks (Link _ (x, _)) = putStrLn x >> return undefined
printLinks x                   = return x

