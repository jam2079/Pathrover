package require psfgen
topology top_all27_prot_lipid_ligands.rtf
topology top_all22_prot_ntligands.inp
topology top_all36_lipid.rtf
topology top_build_sgm2.inp
readpsf protein_final.psf
coordpdb protein_final.pdb
readpsf combined_memb.psf
coordpdb combined_memb.pdb

writepsf merge_prot_memb.psf
writepdb merge_prot_memb.pdb


