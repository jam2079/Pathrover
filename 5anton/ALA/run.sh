#!/bin/bash
#$ -N qanton
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=20G
#$ -l os=rhel5.4

getprot=$1
prot=$2
step=10

echo $getprot
echo $prot

mkdir -p $prot rmsd/data rmsd/plots distances/data distances/plots strs/tmp

cp functions/* $prot
cp * $prot
cd $prot
rm q* *~

ln -s ~/proteins/$prot\_* .
ln -s /zenodotus/hwlab/scratch/mil2037/BLOCK_BOOTSTRAPPING/ANTON_SIMS/$getprot/protein.psf $prot\_selionized.psf
ln -s /zenodotus/hwlab/scratch/mil2037/BLOCK_BOOTSTRAPPING/ANTON_SIMS/$getprot/fixed.dcd $prot\_selprod.dcd

echo "*****VMD aligning started"
~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./weights.tcl > vmdweights.log -args $getprot $prot $step
~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./align.tcl > vmdalign.log -args $prot
sleep 3
echo "*****VMD finished"

if [ ! -f $prot\_selweialicatprod.dcd ]; then
	echo "*****CatDCD started"
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o $prot\_selweialicatprod.dcd -first 10000 $prot\_selweialiprod.dcd
	echo "*****CatDCD finished"
	sleep 3
fi

if [ ! -f $prot\_fixed.dcd ]; then
	echo "*****Fixing started"
	sh fix_symmetry.sh $prot
	echo "*****Fixing finished"
	sleep 3
fi

if [ "$(prot)" == "$(getprot)" ]; then
	echo "*****VMD RMSD started"
	/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./rmsdcalc.tcl > vmdrmsdcalc.log -args $prot
	echo "*****VMD finished"
	if [ ! -f ../strs/$prot\_str.dat ]; then
		echo "*****VMD str started"
		/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./ss.tcl > vmdss.log -args $prot
		echo "*****VMD finished"
		echo "*****R str started"
		/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript define_tms.R $prot
		echo "*****R finished"
	fi
fi

rm $prot\_selionized.psf $prot\_selprod.dcd
mv $prot\_* ~/proteins
rm $prot\_*

echo "*****R rmsd started"
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript plotgen.R $prot
echo "*****R finished"

cd ../..

