from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

env.io.hetatm = True
env.io.water = True

class MyModel(automodel):
    def select_atoms(self):
        return selection(self.residue_range('1:', '10:'),
                         self.residue_range('512:', '515:'),
                         self.residues['11'], self.residues['12'], self.residues['14'], self.residues['15'], self.residues['16'], self.residues['21'], self.residues['23'], self.residues['140'], self.residues['191'],
                         self.residues['235'], self.residues['237'], self.residues['238'], self.residues['239'], self.residues['262'], self.residues['271'], self.residues['272'], self.residues['273'], self.residues['316'],
                         self.residues['420'], self.residues['443'], self.residues['469'], self.residues['472'], self.residues['474'], self.residues['475'], self.residues['476'], self.residues['480'], self.residues['487'],
                         self.residues['508'], self.residues['510'])
                         
    def special_restraints(self, aln):
        rsr = self.restraints
        at = self.atoms
        rsr.add(secondary_structure.alpha(self.residue_range('506:', '513:')))


a = MyModel(env, alnfile = 'alignment.ali',
              knowns = 'chainA_protein', sequence = 'LeuT_fill')
a.starting_model= 1
a.ending_model  = 1

#a.md_level = None # No refinement of model

a.make()

