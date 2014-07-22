#!/bin/bash

qsub -t 100 run.sh 3 LeuT PRo
sleep 3
qsub -t 100 run.sh 3 LeuT PRoc
sleep 3

qsub -t 100 run.sh 3 Mhp1 PRi
sleep 3
qsub -t 100 run.sh 3 Mhp1 PRo
sleep 3
qsub -t 100 run.sh 3 Mhp1 PRoc
sleep 3

qsub -t 100 run.sh 3 LeuT PRoBB
sleep 3
qsub -t 100 run.sh 3 LeuT PRocBB
sleep 3

qsub -t 100 run.sh 3 Mhp1 PRiBB
sleep 3
qsub -t 100 run.sh 3 Mhp1 PRoBB
sleep 3
qsub -t 100 run.sh 3 Mhp1 PRocBB
sleep 3

qsub -t 100 run.sh 3 LeuT PRoSC
sleep 3
qsub -t 100 run.sh 3 LeuT PRocSC
sleep 3

qsub -t 100 run.sh 3 Mhp1 PRiSC
sleep 3
qsub -t 100 run.sh 3 Mhp1 PRoSC
sleep 3
qsub -t 100 run.sh 3 Mhp1 PRocSC

