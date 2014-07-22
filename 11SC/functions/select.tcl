proc select {end bb} {

	set name "protein/out.psf"
	set test [file exists $name]
	if { $test == 0 } {
	
		set sel [atomselect top "protein and sidechain"]
		$sel writepsf "protein/out.psf"

		set nf [molinfo top get numframes]

		animate write dcd {protein/out.dcd} beg 0 end [expr $nf - 1] waitfor all sel $sel
	}
}

