#!/bin/bash
#$ -N qtransfer4
#$ -cwd
#$ -j y
#$ -m as
#$ -M jam2079@med.cornell.edu
#$ -l h_vmem=4G
#$ -l os=rhel5.4

prot=$1

echo $prot
echo mem4G

cp * $prot
cp functions/* $prot
cd $prot
rm q* *~

ln -s  ../../proteins/$prot\_selweiionized.psf .
ln -s  ../../proteins/$prot\_fixed_long.dcd .

for n in {0..110};
	do /softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./createpdb.tcl -args $prot $n
	cat dcd* > file_all$n\.pdb
	rm dcd*
	nn=`printf "%04d" $n`
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o file_all$nn\.dcd -pdb file_all$n\.pdb
	rm file_all*.pdb
done

/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o DAT_run$run\_transfer.dcd file*

mv $prot\_* ../../proteins
rm file_all*
