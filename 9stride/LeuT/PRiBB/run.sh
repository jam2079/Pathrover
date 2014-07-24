#!/bin/bash
#$ -N qstride
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=2G
#$ -l os=rhel5.4

prot=$1
state=$2

echo $prot
echo $state

mkdir -p strs
mkdir -p $prot/$state/protein
cp * $prot/$state
cd $prot/$state
rm q*

ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$prot/$state/selweiionized.psf protein/
ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$prot/$state/fixed.dcd protein/

if [ ! -f "../../pdbs/$prot\_$state\_frame_1000.pdb" ]; then
	echo "*****VMD started writting strs"
	/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./ss.tcl > vmdss.log -args $prot $state
	echo "*****VMD finished"
fi

rm -rf protein

#cd ../../strs
#for pdb in $( ls ../pdbs ); do
#	if [ ! -f "$pdb.str" ]; then
#		echo "*****STRIDE started"
#		~/stride/stride -mFile ../pdbs/$pdb > $pdb.str
#		echo "*****STRIDE finished"
#	fi
#done
#cd ..



