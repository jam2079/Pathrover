package require psfgen
topology top_all27_prot_lipid_ligands.rtf
pdbalias residue HOH TIP3
pdbalias atom HOH O OH2

segment SOLV {
    auto none
    pdb SOLV_trans.pdb
}
coordpdb SOLV_trans.pdb SOLV

guesscoord
writepdb SOLV_final.pdb
writepsf SOLV_final.psf


