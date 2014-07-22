#PBS -l nodes=16:ppn=8,walltime=48:00:00
#PBS -N 3tt1
#PBS -j oe
#PBS -q regular
#PBS -V
##PBS -m abe jam2079@med.cornell.edu
##PBS -W depend=afterok:5393527.cvrsvc09

cd $PBS_O_WORKDIR

module load namd

mpirun -np 128 namd2 rho_production_9.in >& rho_production_9.out

