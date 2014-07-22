package require psfgen
topology top_BHY_hyd_mod.rtf
topology BHY_hyd_mod.rtf
mol load BHY.pdb

segment LIG {pdb BHY.pdb}
coordpdb BHY.pdb LIG 

#regenerate dihedrals angles
#guesscoord

writepsf ligand.psf
writepdb ligand.pdb

exit
