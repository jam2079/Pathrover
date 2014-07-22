#!/bin/bash/

TMPFILE=./tmp.$$
for filename in carver_*.sh bring.sh preparethere.sh *vmd; do
sed 's/XXXX/3tt3/g' $filename > $TMPFILE
mv $TMPFILE $filename
done
