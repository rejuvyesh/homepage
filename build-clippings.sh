#!/bin/sh
#
# File: build-clippings.sh
#
# Created: Tuesday, June 24 2014 by rejuvyesh <mail@rejuvyesh.com>
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>
#

cat templates/clippings.md > clippings.md
clippings2md ~/books/reading_list/My\ Clippings.txt >> clippings.md
cat templates/comments.html >> clippings.md
git add clippings.md && git commit -m "Update clippings `date`"
