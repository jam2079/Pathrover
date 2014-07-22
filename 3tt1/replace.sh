#!/bin/bash/

TMPFILE=./tmp.$$
for filename in carver_*.sh bring.sh; do
sed 's/XXXX/3tt1/g' $filename > $TMPFILE
mv $TMPFILE $filename
done
