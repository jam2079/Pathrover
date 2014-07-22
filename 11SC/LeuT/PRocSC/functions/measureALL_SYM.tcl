mol new selionized.psf
mol addfile selweialicatprod.dcd waitfor all
set nf [molinfo top get numframes]

# Begin loop through all the frames of the trajectory.

set glu_file [open "glu_data.txt" a+]
set asp_file [open "asp_data.txt" a+]
set arg_file [open "arg_data.txt" a+]
set phe_file [open "phe_data.txt" a+]

set glu [atomselect top "(name OE2 and resname GLU)"]
set asp [atomselect top "(name OD2 and resname ASP)"]
set arg [atomselect top "(name CA and resname ARG)"]
set phe [atomselect top "name CA and (resname PHE or resname TYR)"]

for {set f 0} {$f < $nf} {set f [expr $f + 1]} {
	set glu_list {}
	foreach res [$glu get resid] {
		set sel [atomselect top "resid $res and name N CA CD OE2"]
		set angle [measure dihed [$sel list] frame $f]
		lappend glu_list $angle
		$sel delete
	}
        puts $glu_file "$glu_list"
	set asp_list {}
	foreach res [$asp get resid] {
		set sel [atomselect top "resid $res and name N CA CG OD2"]
		set angle [measure dihed [$sel list] frame $f]
		lappend asp_list $angle
		$sel delete
	}
	puts $asp_file "$asp_list"
	set arg_list {}
	foreach res [$arg get resid] {
		set sel [atomselect top "resid $res and name N CA CZ NH1"]
		set angle [measure dihed [$sel list] frame $f]
		lappend arg_list $angle
		$sel delete
	}
	puts $arg_file "$arg_list"
	set phe_list {}
        foreach res [$phe get resid] {
                set sel [atomselect top "resid $res and name CA CB CG CD1"]
                set angle [measure dihed [$sel list] frame $f]
                lappend phe_list $angle
        }
        puts $phe_file "$phe_list"
}
close $glu_file
close $asp_file
close $arg_file
close $phe_file
