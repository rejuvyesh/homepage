#!/bin/sh
#
# File: build-review.sh
#
# Created: Friday, June 13 2014 by rejuvyesh <mail@rejuvyesh.com>
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>
#

kitab
cat templates/review.md > book-reviews.md
gr2md ~/archive/goodreads-export.csv >> book-reviews.md
git add book-reviews.md && git commit -m "Update reviews `date`"
