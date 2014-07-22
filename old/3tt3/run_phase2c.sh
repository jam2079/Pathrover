#!/bin/bash -l
#$ -N LeuTi3tt3
#$ -j y
#$ -cwd
#$ -pe charmrun 24
#$ -q standard.q
#$ -l t2050=0
#$ -R y
#$ -l mib=1
#$ -l excl=1
##$ -hold_jid 6040


#BUILD_ROOT=/home/jason/namd_gpu_pug
#GPU_CLAUSE="+idlepoll"
BUILD_ROOT=/home/jason/namd_nogpu_pug
GPU_CLAUSE=""

cd $SGE_O_WORKDIR

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2c/rho_equil_phase2c.in > phase2c/rho_equil_phase2c.out


