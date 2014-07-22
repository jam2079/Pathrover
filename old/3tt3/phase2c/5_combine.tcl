package require psfgen
topology top_all27_prot_lipid_ligands.rtf
topology top_all22_prot_ntligands.inp
topology top_all36_lipid.rtf
topology top_build_sgm2.inp
readpsf combined_protmembwater.psf
coordpdb combined_protmembwater.pdb
readpsf ions_final.psf
coordpdb ions_final.pdb

writepsf ionized.psf
writepdb ionized.pdb

