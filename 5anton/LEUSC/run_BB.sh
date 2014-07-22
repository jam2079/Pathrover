#!/bin/bash
#$ -N qBB
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=30M
#$ -l os=rhel5.4

prot=$1

mkdir -p BB

#grep "  CA   " "  C    " "  N    " "  O    " "  OT1  " "  OT2  " ../proteins/$prot\_selweiionized.psf > BB/$prot\_BB.dat
netstat -anp | egrep '(PROA)|(PROB)|( HETA )' ../proteins/$prot\_selweiionized.psf > BB/$prot\_BB_tmp1.dat
cut -c1-29 BB/$prot\_BB\_tmp1.dat > BB/$prot\_BB\_tmp2.dat
netstat -anp | egrep '(  C    )|(  N    )|(  O    )|(  CA   )|(  OT1  )|(  OT2  )|(  SOD  )' BB/$prot\_BB_tmp2.dat > BB/$prot\_BB_tmp3.dat
awk -F" " '{print $1}' BB/$prot\_BB_tmp3.dat > BB/$prot\_BB.dat
