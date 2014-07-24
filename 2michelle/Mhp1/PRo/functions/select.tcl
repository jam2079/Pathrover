proc select {end} {

	set name "protein/selionized.psf"
	set test [file exists $name]
	if { $test == 0 } {
	
		set sel [atomselect top "not hydrogen and serial 1 to $end"]
		$sel writepsf "protein/selionized.psf"

		set nf [molinfo top get numframes]

		animate write dcd {protein/selprod.dcd} beg 0 end [expr $nf - 1] waitfor all sel $sel
	}
}

