#!/bin/bash

qsub -t 1-14 run.sh 3 LeuT PRoSC
sleep 3
qsub -t 1-14 run.sh 3 LeuT PRocSC
sleep 3

qsub -t 1-14 run.sh 3 Mhp1 PRiSC
sleep 3
qsub -t 1-14 run.sh 3 Mhp1 PRoSC
sleep 3
qsub -t 1-14 run.sh 3 Mhp1 PRocSC

