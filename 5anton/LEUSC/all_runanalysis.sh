#!bin/bash/

qsub -t 100 runanalysis.sh LEU
sleep 3
qsub -t 100 runanalysis.sh LEUBB
sleep 3
qsub -t 100 runanalysis.sh LEUSC
sleep 3

qsub -t 100 runanalysis.sh LEU_VAL
sleep 3
qsub -t 100 runanalysis.sh LEU_VALBB
sleep 3
qsub -t 100 runanalysis.sh LEU_VALSC
sleep 5

qstat

