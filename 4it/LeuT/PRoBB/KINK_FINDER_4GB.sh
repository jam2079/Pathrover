#!/bin/bash
#$ -N array_bootstrap_analysis
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=4G
#$ -l os=rhel5.4

# 1 is number of bootstraps to look at 
# 2 is window size
# 3 is dcd file

/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript kink_finder.R $1 $2 $3 > ${1}_${2}_${3}_kink_finder.Rout

