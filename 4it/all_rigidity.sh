#!/bin/bash

qsub -t 1-14 run$1.sh 3 LeuT PRoBB
sleep 3
qsub -t 1-14 run$1.sh 3 LeuT PRocBB
sleep 3

qsub -t 1-14 run$1.sh 3 Mhp1 PRiBB
sleep 3
qsub -t 1-14 run$1.sh 3 Mhp1 PRoBB
sleep 3
qsub -t 1-14 run$1.sh 3 Mhp1 PRocBB

