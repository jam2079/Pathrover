#!/bin/bash
#$ -N qsweeprigidity
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=16G
#$ -l os=rhel5.4

num=5
prot=$1
tm=$SGE_TASK_ID

echo num$num
echo $prot
echo tm$tm
echo mem16G

mkdir -p sweeprigidity/data sweeprigidity/plots

cp * $prot
cp functions/* $prot
cd $prot
rm q* *~

/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript sweeprigidity.R $num $prot $tm

cd ..
