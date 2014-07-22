#!/bin/bash/

TMPFILE=./tmp.$$
for filename in *.in; do
sed 's/jam2079/jam2079\/Pathrover/g' $filename > $TMPFILE
mv $TMPFILE $filename
done
