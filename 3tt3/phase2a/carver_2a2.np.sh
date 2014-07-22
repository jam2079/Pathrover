#PBS -l nodes=16:ppn=8,walltime=48:00:00
#PBS -N 3tt3_2a2.np
#PBS -j oe
#PBS -q regular
#PBS -V
#PBS -m ae
#PBS -M jaime.medina.manresa@gmail.com
##PBS -W depend=afterok:5393527.cvrsvc09

cd $PBS_O_WORKDIR

module load namd

mpirun -np 128 namd2 rho_equil_phase2a2.np.in >& rho_equil_phase2a2.np.out

#ALSO MODIFY NAME
