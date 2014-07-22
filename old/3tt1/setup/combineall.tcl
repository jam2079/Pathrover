package require psfgen
topology top_all27_prot_lipid_ligands.rtf
topology top_all22_prot_ntligands.inp
readpsf protein.psf
coordpdb protein.pdb
readpsf internal_ions.psf
coordpdb internal_ions.pdb
readpsf SOLV.psf
coordpdb SOLV.pdb

writepsf combined.psf
writepdb combined.pdb

