# Get the sequence of the 1qg8 PDB file, and write to an alignment file
code = '3tt1_chainA_proteinintsolv'

e = environ()
m = model(e, file=code)
aln = alignment(e)
aln.append_model(m, align_codes=code)
aln.write(file=code+'.seq')

