#!/bin/bash
#$ -N qrun
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=30G
#$ -l os=rhel5.4

Prot=$1
StateP=$2
State=$3

mkdir $Prot
mkdir $Prot/$State
mkdir $Prot/$State/protein
mkdir $Prot/$State/distancedata
mkdir $Prot/$State/rmsd
mkdir $Prot/$State/smoothdistanceplots $Prot/$State/smoothdistanceplots/Na2 $Prot/$State/smoothdistanceplots/S1 $Prot/$State/smoothdistanceplots/InGate $Prot/$State/smoothdistanceplots/OutGate
mkdir /zenodotus/hwlab/scratch/jam2079/proteins/$Prot
mkdir /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$State

if [ $Prot == LeuT ]; then
	mkdir $Prot/$State/smoothdistanceplots/Na1 $Prot/$State/smoothdistanceplots/S2
fi

cp -rf functions $Prot/$State
cp first.tcl $Prot/$State
cp second.tcl $Prot/$State
cp plotgen.R $Prot/$State
cp xvfb_wrapper.sh $Prot/$State
cd $Prot/$State

ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$State/sel* protein/
ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$State/ifit* protein/
ln -s ~mis2066/Pathrover/$Prot/MD/$StateP/common/ionized.psf protein/
ln -s ~mis2066/Pathrover/$Prot/MD/$StateP/trajectory/all.dcd protein/prod.dcd

echo "*****VMD started"
#/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./first.tcl > file.log
./xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./first.tcl > file.log -args $Prot $State
./xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./second.tcl > file.log -args $Prot $State
echo "*****VMD finished"
sleep 3

if [ ! -f /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$State/selweialicatprod.dcd ]; then
	echo "*****CatDCD started"
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o protein/selweialicatprod.dcd -first 1001 protein/selweialiprod.dcd
	echo "*****CatDCD finished"
fi

sleep 3

if [ ! -f /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$State/fixed.dcd ]; then
	echo "*****Fixing started"
	cp functions/* protein/
	cd protein
	sh fix_symmetry.sh
	rm *tcl *sh *txt *log *R *Rout
	cd ..
	echo "*****Fixing finished"
fi

rm protein/ionized.psf
rm protein/prod.dcd
mv protein/* /zenodotus/hwlab/scratch/jam2079/proteins/$Prot/$State/
rm -rf protein

echo "*****R started"
#/softlib/exe/x86_64/bin/R CMD BATCH ./plotgen.R
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript plotgen.R $Prot $State
echo "*****R finished"

cd ../..

