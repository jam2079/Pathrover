#!/bin/bash/

TMPFILE=./tmp.$$
for filename in carver_*.sh bring.sh preparethere.sh *vmd; do
sed 's/XXXX/2jlo/g' $filename > $TMPFILE
mv $TMPFILE $filename
done
