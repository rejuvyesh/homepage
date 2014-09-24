-- File: Config.hs
-- Copyright rejuvyesh <mail@rejuvyesh.com>, 2014
-- License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>

module Site.Config
    ( config
    , feedConfiguration
    ) where


import           Hakyll


config :: Configuration
config = defaultConfiguration
    { deployCommand = "/usr/bin/cp -rf _site/* ../rejuvyesh.github.io/ && cd ../rejuvyesh.github.io/ && git add -A && git commit -m \"update\" && git push origin"
    }

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
    { feedTitle       = "Rejuvyesh's Whisperings into the Wire"
    , feedDescription = "Personal blog of Jayesh Kumar Gupta"
    , feedAuthorName  = "Jayesh Kumar Gupta"
    , feedAuthorEmail = "mail@rejuvyesh.com"
    , feedRoot        = "http://rejuvyesh.com"
    }
