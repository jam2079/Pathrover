
#source functions/distance.tcl
#source functions/rmsd.tcl
#source functions/select.tcl

set prot [lindex $argv 0]
set step [lindex $argv 1]

### ALIGN USING WEIGHTING ALGORITHM

### GENERATE WEIGHTS FILE

mol new "$prot\_selionized.psf" waitfor all
mol off top
mol addfile "$prot\_selprod.dcd" type dcd first 0 last -1 step $step waitfor all
set mol top

set name "$prot\_ifitbyres_stride_$step.dat"
set test [file exists $name]
if { $test == 0 } {

	::rmsdtt::rmsdtt
	set ::rmsdtt::bb_only 0
	set ::rmsdtt::trace_only 1
	set ::rmsdtt::noh 0

	set ::rmsdtt::ifit_file $name
	::rmsdtt::iterativeFit
	sleep 3

	menu rmsdtt off
}

### CREATE NEW PSF FILE WITH WEIGHTS

set name "$prot\_selweiionized.psf"
set test [file exists $name]
if { $test == 0 } {


	set fp [open "$prot\_ifitbyres_stride_$step.dat" r]
	set filedata [read $fp]
	close $fp
	set data [split $filedata "\n"]

	set selall [atomselect top "all"]
	$selall set charge 0
	set selca [atomselect top "name CA"]

	set nres [llength [$selca get index]]
	puts $nres
	for {set i 0} {$i < $nres} {incr i} {
		set it [expr $i+$nres]

		set sel [atomselect top "resid $i"]
		$sel set charge [ lindex [lindex $data $it] 6 ]
	}

	$selall writepsf $name
	sleep 3
}

