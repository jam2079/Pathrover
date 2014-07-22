#!/bin/bash
#$ -N qwholeant
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=30G
#$ -l os=rhel5.4

prot=$1
step=10

echo $prot

mkdir -p $prot rmsd/data rmsd/plots strs/tmp

cp functions/* $prot
cp * $prot
cd $prot
rm q* *~

ln -s /zenodotus/hwlab/scratch/mil2037/BLOCK_BOOTSTRAPPING/ANTON_SIMS/$prot/protein.psf $prot\_selionized.psf
ln -s /zenodotus/hwlab/scratch/mil2037/BLOCK_BOOTSTRAPPING/ANTON_SIMS/$prot/fixed.dcd $prot\_selprod.dcd
ln -s ~/Pathrover/proteins/$prot\_* .

if [ ! -f $prot\_selweialiprod.dcd ]; then
if [ ! -f $prot\_selweialicatprod.dcd ]; then
if [ ! -f $prot\_fixed.dcd ]; then
	echo "*****VMD aligning started"
	~/scripts/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./weights.tcl > vmdweights.log -args $prot $step
	~/scripts/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./align.tcl > vmdalign.log -args $prot
	sleep 3
	echo "*****VMD finished"
fi
fi
fi

if [ ! -f $prot\_selweialicatprod.dcd ]; then
if [ ! -f $prot\_fixed.dcd ]; then
	echo "*****CatDCD started"
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o $prot\_selweialicatprod.dcd -first 10000 $prot\_selweialiprod.dcd
	echo "*****CatDCD finished"
	sleep 3
fi
fi

if [ ! -f $prot\_fixed_long.dcd ]; then
	echo "*****Fixing started"
	sh fix_symmetry_long.sh $prot
	echo "*****Fixing finished"
	sleep 3
fi

if [ ! -f $prot\_fixed.dcd ]; then
	echo "*****Fixing started"
	sh fix_symmetry.sh $prot
	echo "*****Fixing finished"
	sleep 3
fi

if [ ! -f ../strs/$prot\_str.dat ]; then
	echo "*****VMD str started"
	/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./ss.tcl > vmdss.log -args $prot
	echo "*****VMD finished"
	echo "*****R str started"
	/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript define_tms.R $prot
	echo "*****R finished"
fi

echo "*****VMD RMSD started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./rmsdcalc.tcl > vmdrmsdcalc.log -args $prot
echo "*****VMD finished"
echo "*****R RMSD started"
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript plotgen.R $prot
echo "*****R finished"

rm $prot\_selionized.psf $prot\_selprod.dcd
#mv $prot\_* ~/Pathrover/proteins
find $prot\_* -maxdepth 1 -mindepth 1 -not -name *.Rdata -print0 | xargs -0 mv -t ../../proteins
#rm $prot\_*

cd ../..

