package require psfgen
topology top_all27_prot_lipid_ligands.rtf
topology top_all22_prot_ntligands.inp
readpsf protein_final.psf
coordpdb protein_final.pdb
readpsf internal_ions_final.psf
coordpdb internal_ions_final.pdb
readpsf SOLV_final.psf
coordpdb SOLV_final.pdb

writepsf combined_proteinintsolv.psf
writepdb combined_proteinintsolv.pdb

