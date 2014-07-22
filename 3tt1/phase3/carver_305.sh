#PBS -l nodes=16:ppn=8,walltime=48:00:00
#PBS -N 3tt1_305
#PBS -j oe
#PBS -q regular
#PBS -V
#PBS -m ae
#PBS -M jaime.medina.manresa@gmail.com
##PBS -W depend=afterok:5393527.cvrsvc09

cd $PBS_O_WORKDIR

module load namd

mpirun -np 128 namd2 rho_production_05.in >& rho_production_05.out

