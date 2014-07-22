#cd /Volumes/aristotle/2x79/common/

mol load psf ionized.psf pdb ionized.pdb

source equil_phase1_fix.tcl
source equil_phase1b_fix.tcl
source equil_phase1b_restrain.tcl
source equil_phase2a_restrain.tcl
source equil_phase2b_restrain.tcl

cp rho_phase1_fix.pdb ../phase1
cp rho_equil_phase1b_fix.pdb ../phase1b
cp rho_equil_phase1b_restrain.pdb ../phase1b


source getsize.tcl
