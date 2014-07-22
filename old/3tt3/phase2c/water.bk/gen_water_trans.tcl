package require psfgen

topology top_all36_lipid.rtf
#topology top_build_sgm2.inp
mol load water.pdb

segment WT {pdb water.pdb}
coordpdb water.pdb WT

regenerate dihedrals angles
guesscoord

writepsf water_final.psf
writepdb water_final.pdb

exit
