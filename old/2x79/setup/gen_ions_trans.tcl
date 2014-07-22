package require psfgen
topology top_all27_prot_lipid_ligands.rtf
mol load internal_ions_trans.pdb

segment INT {pdb internal_ions_trans.pdb}
coordpdb internal_ions_trans.pdb INT 

#regenerate dihedrals angles
#guesscoord

writepsf internal_ions_final.psf
writepdb internal_ions_final.pdb

