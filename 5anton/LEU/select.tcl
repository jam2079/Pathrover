
set getprot [lindex $argv 0]
set prot [lindex $argv 1]
set que [lindex $argv 2]

set name "$prot\_selweiionized.psf"
set test [file exists $name]
if { $test == 0 } {

	mol new "$getprot\_selweiionized.psf" waitfor all
	mol off top
	mol addfile "$getprot\_selweialiprod.dcd" type dcd first 0 last -1 waitfor all
	set mol top

	if { $que == "BB" } {
	set sel [atomselect top "backbone and (segname PROA or segname PROB) or name SOD"]
	}
	if { $que == "SC" } {
	set sel [atomselect top "sidechain and (segname PROA or segname PROB) or name SOD"]
	}
	$sel writepsf $name

	set nf [molinfo top get numframes]

	animate write dcd "$prot\_selweialiprod.dcd" beg 0 end [expr $nf - 1] waitfor all sel $sel
}

set name "$prot\_fixed.dcd"
set test [file exists $name]
if { $test == 0 } {

	mol delete all
	mol new "$getprot\_selweiionized.psf" waitfor all
	mol off top
	mol addfile "$getprot\_fixed.dcd" type dcd first 0 last -1 waitfor all
	set mol top

	if { $que == "BB" } {
	set sel [atomselect top "backbone and (segname PROA or segname PROB) or name SOD"]
	}
	if { $que == "SC" } {
	set sel [atomselect top "sidechain and (segname PROA or segname PROB) or name SOD"]
	}

	set nf [molinfo top get numframes]

	animate write dcd $name beg 0 end [expr $nf - 1] waitfor all sel $sel
}


