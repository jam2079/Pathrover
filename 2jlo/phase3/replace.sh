#!/bin/bash/

TMPFILE=./tmp.$$
for filename in *.sh; do
sed 's/\#\#PBS\ \-m\ abe\ jam2079\@med\.cornell\.edu/\#PBS\ \-m\ ae/g' $filename > $TMPFILE
mv $TMPFILE $filename
done
