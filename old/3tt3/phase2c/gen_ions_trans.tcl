package require psfgen
topology top_all27_prot_lipid_ligands.rtf
mol load ions_trans.pdb

segment ION {pdb ions_trans.pdb}
coordpdb ions_trans.pdb ION

#regenerate dihedrals angles
#guesscoord

writepsf ions_final.psf
writepdb ions_final.pdb

exit
