proc rmsd {reference_sel} {

	set name "rmsd/rmsd.dat"
	set test [file exists $name]
	if { $test == 0 } {

		set nf [molinfo top get numframes]

		set datafile [open "rmsd/rmsd.dat" a+]

		set ref_sel [$reference_sel get resid]

		for {set f 0} {$f < $nf} {set f [expr $f + 1]} {
			set comparison_sel [atomselect top "name CA and resid $ref_sel" frame $f]
#			set transformation_mat [measure fit $comparison_sel $reference_sel]
#			set move_sel [atomselect top "all" frame $f]
#			$move_sel move $transformation_mat
			set rmsd_backbone [measure rmsd $reference_sel $comparison_sel]
			puts $datafile "$rmsd_backbone"
			$comparison_sel delete
#			$move_sel delete
		}

		set sel [atomselect top "all"]

		close $datafile
	}

#	set name "protein/selprodali.dat"
#	set test [file exists $name]
#	if { $test == 0 } {

#		set nf [molinfo top get numframes]

#		set ref_sel [$reference_sel get resid]

#		for {set f 0} {$f < $nf} {set f [expr $f + 1]} {
#			set comparison_sel [atomselect top "name CA and resid $ref_sel" frame $f]
#			set transformation_mat [measure fit $comparison_sel $reference_sel]
#			set move_sel [atomselect top "all" frame $f]
#			$move_sel move $transformation_mat
#			set rmsd_backbone [measure rmsd $reference_sel $comparison_sel]
#			$comparison_sel delete
#			$move_sel delete
#		}

#		set sel [atomselect top "all"]

#		animate write dcd {protein/selprodali.dcd} beg 0 end [expr $nf - 1] waitfor all sel $sel
#	}
}

proc rmsdtm {num reference_sel} {

	set name "rmsd/rmsd tm $num.dat"
	set test [file exists $name]
	if { $test == 0 } {

		set nf [molinfo top get numframes]

		set datafile [open "rmsd/rmsd tm $num.dat" a+]

		set ref_sel [$reference_sel get resid]

		for {set f 0} {$f < $nf} {set f [expr $f + 1]} {
			set comparison_sel [atomselect top "name CA and resid $ref_sel" frame $f]
			set transformation_mat [measure fit $comparison_sel $reference_sel]
			set move_sel [atomselect top "all" frame $f]
			$move_sel move $transformation_mat
			set rmsd_backbone [measure rmsd $reference_sel $comparison_sel]
			puts $datafile "$rmsd_backbone"
			$comparison_sel delete
			$move_sel delete
		}

		set sel [atomselect top "all"]

		close $datafile
	}
}
