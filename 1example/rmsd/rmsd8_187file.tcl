# Prints the RMSD of the protein atoms between each timestep
# and the first timestep for the top molecule
# source functions/first.tcl
set file [open "frame_rmsd8_187.dat" w]

# use frame 0 for the reference
set reference [atomselect $mol "type CA and (resid 8 187)" frame 0]
# the frame being compared
set compare [atomselect $mol "type CA and (resid 8 187)"]

set num_steps [molinfo $mol get numframes]
for {set frame 0} {$frame < $num_steps} {incr frame} {
        # get the correct frame
        $compare frame $frame

        # compute the transformation
        set trans_mat [measure fit $compare $reference]
        # do the alignment
        $compare move $trans_mat
        # compute the RMSD
        set rmsd [measure rmsd $compare $reference]
        # print the RMSD
        puts $file $rmsd
}

close $file

