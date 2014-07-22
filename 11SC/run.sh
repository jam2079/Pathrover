#!/bin/bash
#$ -N qrun
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=2G
#$ -l os=rhel5.4

Prot=$1
StateP=$2
State=$3

echo $Prot
echo $State

mkdir -p $Prot/$State/protein
mkdir -p /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$State

cp first.tcl $Prot/$State
cp -r functions $Prot/$State
cd $Prot/$State

ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$StateP/selweiionized.psf protein/
ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$StateP/fixed.dcd protein/

echo "*****VMD started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./first.tcl > vmdfirst.log -args $Prot $State
echo "*****VMD finished"

rm protein/selweiionized.psf
rm protein/fixed.dcd
mv protein/out.psf protein/selionized.psf
mv protein/out.dcd protein/fixed.dcd
mv protein/* /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$State/
rm -rf protein

cd ../..

