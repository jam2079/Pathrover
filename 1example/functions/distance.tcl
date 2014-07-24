proc distance {r1 r2} {

	set mol top

	set num_steps [molinfo $mol get numframes]

	set name "distancedata/distance $r1 $r2.dat"
	set outfile [open $name w]

	for {set f 0} {$f < $num_steps} {incr f} {
                set sel_1 [atomselect top "resid $r1" frame $f]
                set sel_2 [atomselect top "resid $r2" frame $f]
		set md 1e8
                foreach atom1 [$sel_1 list] {
                        foreach atom2 [$sel_2 list] {
				set m [measure bond [list $atom1 $atom2] frame $f]
				if {$m < $md} {set md $m}
                        }
                }
		puts $outfile $md
                $sel_1 delete
                $sel_2 delete
        }
	close $outfile
}




proc distanceall {} {

	set mol top

	set num_steps [molinfo $mol get numframes]
	set ALL {5 187 267 268 361 369 29 30 107 111 114 319 320 324 400 404 253 25 105 108 256 259 355 359 254 517 519 22 27 286 23 351 354 516}

	foreach r1 $ALL {
		foreach r2 $ALL {if { $r1 < $r2 } {
			set name "distancedata/distance $r1 $r2.dat"
			set test [file exists $name]
			if { $test == 0 } {
				set outfile [open $name w]

				for {set f 0} {$f < $num_steps} {incr f} {
				        set sel_1 [atomselect top "resid $r1" frame $f]
				        set sel_2 [atomselect top "resid $r2" frame $f]
					set md 1e6
				        foreach atom1 [$sel_1 list] {
				                foreach atom2 [$sel_2 list] {if { $atom1 < $atom2 } {
							set m [measure bond [list $atom1 $atom2] frame $f]
							if {$m < $md} {set md $m}
				                }}
				        }
					puts $outfile $md
				        $sel_1 delete
				        $sel_2 delete
				}
				close $outfile
			}
		}}
	}
}


