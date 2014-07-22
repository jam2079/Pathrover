#!/bin/bash
#$ -N qantevol4
#$ -cwd
#$ -j y
#$ -m as
#$ -M jam2079@med.cornell.edu
#$ -l h_vmem=4G
#$ -l os=rhel5.4

prot=$1
num=$SGE_TASK_ID

echo start$num
echo $prot
#echo tm$tm
echo mem4G

mkdir -p $prot
mkdir -p rigidity/evol/data rigidity/evol/plots
mkdir -p pairwise/evol/data pairwise/evol/plots
mkdir -p sweep/evol/data sweep/evol/plots

cp * $prot
cp functions/* $prot
cd $prot
rm q* *~

#/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript ANALYSIS_evol_new.R $prot $num

cd ../pairwise/evol
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript heatmap_evol.R $prot $num

cd ../../sweep/evol
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript sweep_heatmap_evol.R $prot $num

cd ..
