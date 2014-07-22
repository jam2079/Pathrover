from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

env.io.hetatm = True
env.io.water = True

# Create a new class based on 'loopmodel' so that we can redefine
# select_loop_atoms
class MyLoop(loopmodel):
    # This routine picks the residues to be refined by loop modeling
    def select_loop_atoms(self):
        # Two residue ranges (both will be refined simultaneously)
        return selection(self.residue_range('130:', '134:'),
                         self.residue_range('506:', '513:'))

a = MyLoop(env,
           alnfile  = 'alignment_ref.ali',      # alignment filename
           knowns   = 'LeuT_fill.B99990001',               # codes of the templates
           sequence = 'LeuT_fill',               # code of the target
           loop_assess_methods=assess.DOPE) # assess each loop with DOPE

a.starting_model= 1
a.ending_model  = 1

a.md_level = None # No refinement of model

a.make()

