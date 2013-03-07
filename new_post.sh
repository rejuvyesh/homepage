#!/bin/sh

###########################################################
# Script to create a new blog-post file in proper format  #
# and start the editor                                    #
###########################################################

date_pattern=`date "+%Y-%m-%d"`-

# Ask for Post Name
read -r -p "Post name > "
title=${REPLY}
clean_title=`echo $title | tr "[:upper:]" "[:lower:]"]` #Lower Case
clean_title=`echo $clean_title | iconv -f utf-8 -t ascii//translit` #Remove accents
clean_title=`echo $clean_title | tr -dc '[a-z0-9\. -_]'` #Keep spaces and letters
clean_title=`echo $clean_title | tr -d '[!?@#$%\^&"']'` #Remove punctuations
clean_title=`echo $clean_title | tr " " "-"` #Replace spaces by dashes

filename=$date_pattern$clean_title.md
author=`git config --get user.name`

cat > "posts/"$filename <<EOF
---
title: $title
description: 
author: $author
status: in progress
lastmodified:
belief:
tags: 
---

EOF

$HOME/Scripts/emacs-gui "posts/"$filename
