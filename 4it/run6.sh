#!/bin/bash
#$ -N qanalysis
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=60G
#$ -l os=rhel5.4

num=$1
prot=$2
state=$3
tm=$SGE_TASK_ID

echo num$num
echo $prot
echo $state
echo tm$tm
echo mem60G

mkdir -p rigidity/data rigidity/plots
cp functions/* $prot/$state
cd $prot/$state

/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript ANALYSIS.R $num $prot $state $tm
