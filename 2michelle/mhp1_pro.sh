#!/bin/bash

Prot=Mhp1
State=PRo

rm -rf $Prot/$State/functions
mkdir $Prot
mkdir $Prot/$State
cp -rf functions $Prot/$State
cp first_$Prot\_$State.tcl $Prot/$State/first.tcl
cp plotgen_$Prot\_$State.R $Prot/$State/plotgen.R
cd $Prot/$State



mkdir protein
mkdir distancedata distancedata/Na1
mkdir rmsd

ln -s ~mis2066/Pathrover/$Prot/MD/$State/common/ionized.psf protein/
ln -s ~mis2066/Pathrover/$Prot/MD/$State/trajectory/prod.dcd protein/

/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./first.tcl > file.log

rm protein/ionized.psf
rm protein/prod.dcd

mkdir distanceplots distanceplots/Na1
mkdir smoothdistanceplots smoothdistanceplots/Na1

/softlib/exe/x86_64/bin/R CMD BATCH ./plotgen.R

cd ../..

