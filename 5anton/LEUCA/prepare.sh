#!/bin/bash

prot=$1

#mkdir -p glycines
mkdir -p $prot

cp * $prot
cp functions/* $prot
cd $prot
rm q* *~

ln -s ~/Pathrover/proteins/$prot\_selweiionized.psf .
#ln -s ~/Pathrover/proteins/$prot\_fixed_long.dcd .

sh getIL2.sh $prot

#qsub -t 1-5 BOOTSTRAPPING_TMP.sh $prot
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 200
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 500
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 1000
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 2000

#qsub ANALYSIS.sh 50 1 fixed.dcd
#qsub ANALYSIS.sh 50 200 fixed.dcd
#qsub ANALYSIS.sh 50 500 fixed.dcd
#qsub ANALYSIS.sh 50 1000 fixed.dcd
#qsub ANALYSIS.sh 50 2000 fixed.dcd

