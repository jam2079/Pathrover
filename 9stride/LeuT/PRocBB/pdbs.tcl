
set prot [lindex $argv 0]
set state [lindex $argv 1]

### GET SELECTION

mol load psf "protein/selweiionized.psf" dcd "protein/fixed.dcd"
set nf [molinfo top get numframes]
for {set i 0 } {$i < $nf} {incr i} {

	set name "../../pdbs/$prot\_$state\_frame_$i.pdb"
	set test [file exists $name]
	if { $test == 0 } {
		[atomselect top all frame $i] writepdb $name
	}
} 

exit

