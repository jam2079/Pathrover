#!/bin/bash/

TMPFILE=./tmp.$$
for filename in *.sh; do
sed 's/XXXX/2jln/g' $filename > $TMPFILE
mv $TMPFILE $filename
done
