#!/bin/bash
#$ -N qSC
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=30M
#$ -l os=rhel5.4

prot=$1

mkdir -p SC

netstat -anp | egrep '(PROA)|(PROB)|( HETA )' ../proteins/$prot\_selweiionized.psf > SC/$prot\_SC_tmp1.dat
cut -c1-29 SC/$prot\_SC\_tmp1.dat > SC/$prot\_SC\_tmp2.dat
netstat -anp | egrep -v '(  C    )|(  N    )|(  O    )|(  CA   )|(  OT1  )|(  OT2  )' SC/$prot\_SC_tmp2.dat > SC/$prot\_SC_tmp3.dat
awk -F" " '{print $1}' SC/$prot\_SC_tmp3.dat > SC/$prot\_SC.dat
