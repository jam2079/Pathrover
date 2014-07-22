#!/bin/bash

Prot=$1
State=$2

mkdir -p $Prot/$State
cd $Prot/$State
cp ../../functions/* .

ln -s ../../../proteins/$Prot/$State/selionized.psf .
ln -s ../../../proteins/$Prot/$State/fixed.dcd .

sh getIL2.sh $Prot

#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 1
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 200
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 500
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 1000
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 2000

#qsub ANALYSIS.sh 50 1 fixed.dcd
#qsub ANALYSIS.sh 50 200 fixed.dcd
#qsub ANALYSIS.sh 50 500 fixed.dcd
#qsub ANALYSIS.sh 50 1000 fixed.dcd
#qsub ANALYSIS.sh 50 2000 fixed.dcd

