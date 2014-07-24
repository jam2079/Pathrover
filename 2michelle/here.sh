#!/bin/bash

Prot=LeuT
State=PRi

scp jam2079@pascal.med.cornell.edu:2michelle/*$Prot\_$State\* .

cp first_$Prot\_$State.tcl .
cp plotgen_$Prot\_$State.R .
mkdir protein

mkdir distancedata distancedata/Na1
mkdir rmsd

mkdir distanceplots distanceplots/Na1
mkdir smoothdistanceplots smoothdistanceplots/Na1

scp jam2079@pascal.med.cornell.edu:2michelle/$Prot/$State/protein/* protein/

