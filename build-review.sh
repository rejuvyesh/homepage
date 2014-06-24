#!/bin/sh
#
# File: build-review.sh
#
# Created: Friday, June 13 2014 by rejuvyesh <mail@rejuvyesh.com>
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>
#

cat templates/review.md > book-reviews.md
gr2md ~/archive/goodreads-export.csv >> book-reviews.md
