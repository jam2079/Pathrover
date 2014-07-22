
### GET SELECTION

source functions/distance.tcl
source functions/rmsd.tcl
source functions/select.tcl

set name "protein/selprod.dcd"
set test [file exists $name]
if { $test == 0 } {

	mol new protein/ionized.psf waitfor all
	mol off top
	mol addfile protein/prod.dcd waitfor all
	set mol top

	select 7236 1

	mol delete all
}



### ALIGN USING WEIGHTING ALGORITHM

### GENERATE WEIGHTS FILE

set step 10

mol delete all
mol new protein/selionized.psf waitfor all
mol off top
mol addfile protein/selprod.dcd type dcd first 0 last -1 step $step waitfor all
set mol top

set name "protein/ifitbyres_stride_$step.dat"
set test [file exists $name]
if { $test == 0 } {

	::rmsdtt::rmsdtt
	set ::rmsdtt::bb_only 0
	set ::rmsdtt::trace_only 1
	set ::rmsdtt::noh 0

	set ::rmsdtt::ifit_file "protein/ifitbyres_stride_$step.dat"
	::rmsdtt::iterativeFit

	menu rmsdtt off
}

### CREATE NEW PSF FILE WITH WEIGHTS

set name "protein/selweiionized.psf"
set test [file exists $name]
if { $test == 0 } {


	set fp [open "protein/ifitbyres_stride_$step.dat" r]
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

	$selall writepsf "protein/selweiionized.psf"
}

### CREATE NEW ALIGNED DCD FILE

set name "protein/selweialiprod.dcd"
set test [file exists $name]
if { $test == 0 } {

	mol delete all
	mol new protein/selweiionized.psf waitfor all
	mol off top
	mol addfile protein/selprod.dcd waitfor all
	set mol top

	::rmsdtt::rmsdtt
	set ::rmsdtt::bb_only 0
	set ::rmsdtt::trace_only 1
	set ::rmsdtt::noh 0
	set ::rmsdtt::weighted_sw 1
	set ::rmsdtt::weighted_mol top
	set ::rmsdtt::weighted_field "charge"
	::rmsdtt::doAlign

	menu rmsdtt off

	set selall [atomselect top "all"]
	set nf [molinfo top get numframes]
	animate write dcd {protein/selweialiprod.dcd} beg 0 end [expr $nf - 1] waitfor all sel $selall
}


mol delete all
mol new protein/selweiionized.psf waitfor all
mol off top
mol addfile protein/selweialiprod.dcd waitfor all
set mol top

rmsd [atomselect top "name CA and (resid 21 to 29 or resid 34 to 43 or resid 50 to 74 or resid 95 to 126 or resid 133 to 149 or resid 154 to 181 or resid 200 to 209 or resid 213 to 223 or resid 234 to 265 or resid 287 to 321 or resid 328 to 343 or resid 352 to 372)" frame 0]

distanceall {38 41 42 309 312 313 318 471 472} 7236 9
distanceall {42 117 121 220 314 318 471 472} 7236 9
distanceall {161 162 163 229 230 231} 7236 9
distanceall {47 48 49 220 360 361 362} 7236 9

rmsdtm 1a [atomselect top "name CA and resid 21 to 29" frame 0]
rmsdtm 1b [atomselect top "name CA and resid 34 to 43" frame 0]
rmsdtm 2 [atomselect top "name CA and resid 50 to 74" frame 0]
rmsdtm 3 [atomselect top "name CA and resid 95 to 126" frame 0]
rmsdtm 4 [atomselect top "name CA and resid 133 to 149" frame 0]
rmsdtm 5 [atomselect top "name CA and resid 154 to 181" frame 0]
rmsdtm 6a [atomselect top "name CA and resid 200 to 209" frame 0]
rmsdtm 6b [atomselect top "name CA and resid 213 to 223" frame 0]
rmsdtm 7 [atomselect top "name CA and resid 234 to 265" frame 0]
rmsdtm 8 [atomselect top "name CA and resid 287 to 321" frame 0]
rmsdtm 9 [atomselect top "name CA and resid 328 to 343" frame 0]
rmsdtm 10 [atomselect top "name CA and resid 352 to 372" frame 0]

