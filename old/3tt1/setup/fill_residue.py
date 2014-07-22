from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

env.io.hetatm = True
env.io.water = True

class MyModel(automodel):
    def special_restraints(self, aln):
        rsr = self.restraints
        at = self.atoms

#       Residues 510 through 513 should be an alpha helix:
        rsr.add(secondary_structure.alpha(self.residue_range('506:', '513:')))


a = MyModel(env, alnfile = 'alignment.ali',
              knowns = '3tt1_chainA_proteinintsolv', sequence = 'LeuT_fill')
a.starting_model= 1
a.ending_model  = 1

#a.md_level = None # No refinement of model

a.make()

