# Prints the RMSD of the protein atoms between each timestep
# and the first timestep for the top molecule
# source functions/first.tcl
set file [open "frame_rmsdall.dat" w]

# use frame 0 for the reference
set reference [atomselect $mol "type CA and (resid 6 to 17 or resid 20 to 33 or resid 36 to 66 or resid 83 to 119 or resid 159 to 177 or resid 183 to 208 or resid 234 to 248 or resid 254 to 260 or resid 268 to 299 or resid 330 to 364 or resid 368 to 388 or resid 392 to 419)" frame 0]
# the frame being compared
set compare [atomselect $mol "type CA and (resid 6 to 17 or resid 20 to 33 or resid 36 to 66 or resid 83 to 119 or resid 159 to 177 or resid 183 to 208 or resid 234 to 248 or resid 254 to 260 or resid 268 to 299 or resid 330 to 364 or resid 368 to 388 or resid 392 to 419)"]

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

