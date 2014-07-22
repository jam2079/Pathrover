package require psfgen
topology top_all27_prot_lipid_ligands.rtf
mol load chainA_ions.pdb

segment INT {pdb chainA_ions.pdb}
coordpdb chainA_ions.pdb INT 

#regenerate dihedrals angles
#guesscoord

writepsf ions.psf
writepdb ions.pdb

exit
