#!/bin/bash
#$ -N qanton
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=6G
#$ -l os=rhel5.4

getprot=$1
prot=$2

echo $getprot
echo $prot

mkdir -p $prot

cp functions/* $prot
cp * $prot
cd $prot
rm q* *~

ln -s ~/proteins/$getprot\_* .
ln -s ~/proteins/$prot\_* .

if [ "$prot" == 'LEUBB' -o "$prot" == 'LEU_VALBB' -o "$prot" == 'ALABB' ] ; then
	que=BB
fi
if [ "$prot" == 'LEUSC' -o "$prot" == 'LEU_VALSC' -o "$prot" == 'ALASC' ] ; then
	que=SC
fi

echo "*****VMD selection BB started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./select.tcl > vmdselect.log -args $getprot $prot $que
echo "*****VMD finished"

rm $getprot\_*
mv $prot\_* ~/proteins
rm $prot\_*

cd ../..

