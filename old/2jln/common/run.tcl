#cd /Volumes/aristotle/2x79/common/

mol load psf ionized.psf pdb ionized.pdb

source equil_phase1_fix.tcl
source equil_phase1b_fix.tcl
source equil_phase1b_restrain.tcl
source equil_phase2a_restrain.tcl
source equil_phase2b_restrain.tcl
source getsize.tcl
