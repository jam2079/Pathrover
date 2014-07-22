proc select {end bb} {

	set name "protein/selionized.psf"
	set test [file exists $name]
	if { $test == 0 } {
	
		if { $bb == 0 } {
			set sel [atomselect top "not hydrogen and serial 1 to $end"]
		}
		if { $bb == 1 } {
			set sel [atomselect top "not hydrogen and serial 1 to $end and not sidechain"]
		}
		$sel writepsf "protein/selionized.psf"

		set nf [molinfo top get numframes]

		animate write dcd {protein/selprod.dcd} beg 0 end [expr $nf - 1] waitfor all sel $sel
	}
}

