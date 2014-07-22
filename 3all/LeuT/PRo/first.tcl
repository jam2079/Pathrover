
source functions/distance.tcl
source functions/rmsd.tcl
source functions/select.tcl

set prot [lindex $argv 0]
set state [lindex $argv 1]
set step 10
set numid -1
if { $prot == "LeuT" } {
	set tms "name CA and (resid 11 to 22 or resid 25 to 37 or resid 41 to 70 or resid 88 to 124 or resid 166 to 183 or resid 191 to 213 or resid 241 to 255 or resid 261 to 266 or resid 276 to 306 or resid 337 to 369 or resid 375 to 395 or resid 399 to 424)"
	set tm1a "name CA and resid 11 to 22"
	set tm1b "name CA and resid 25 to 37"
	set tm2 "name CA and resid 41 to 70"
	set tm3 "name CA and resid 88 to 124"
	set tm4 "name CA and resid 166 to 183"
	set tm5 "name CA and resid 191 to 213"
	set tm6a "name CA and resid 241 to 255"
	set tm6b "name CA and resid 261 to 266"
	set tm7 "name CA and resid 276 to 306"
	set tm8 "name CA and resid 337 to 369"
	set tm9 "name CA and resid 375 to 395"
	set tm10 "name CA and resid 399 to 424"
	set shift 0
	if { $state == "PRi" } {
		set natoms 8244
		set bb 0
		set Na1 {22 27 254 286 515}
		set Na2 {20 23 351 354 355 514}
		set S1 {25 26 104 108 253 254 256 259 355 359 515}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRiBB" } {
		set natoms 8244
		set bb 1
		set Na1 {22 27 254 286 515}
		set Na2 {20 23 351 354 355 514}
		set S1 {25 26 104 108 253 254 256 259 355 359 515}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRo" } {
		set natoms 8244
		set bb 0
		set Na1 {22 27 254 286 593}
		set Na2 {20 23 351 354 355 592}
		set S1 {25 26 104 108 253 254 256 259 355 359 593}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRoBB" } {
		set natoms 8244
		set bb 1
		set Na1 {22 27 254 286 593}
		set Na2 {20 23 351 354 355 592}
		set S1 {25 26 104 108 253 254 256 259 355 359 593}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRoc" } {
		set natoms 8266
		set bb 0
		set Na1 {22 27 254 286 593 514}
		set Na2 {20 23 351 354 355 592}
		set S1 {25 26 104 108 253 254 256 259 355 359 593 514}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRocBB" } {
		set natoms 8266
		set bb 1
		set Na1 {22 27 254 286 593 514}
		set Na2 {20 23 351 354 355 592}
		set S1 {25 26 104 108 253 254 256 259 355 359 593 514}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
}
if { $prot == "Mhp1" } {
	set tms "name CA and (resid 20 to 31 or resid 34 to 44 or resid 50 to 75 or resid 93 to 124 or resid 133 to 148 or resid 155 to 178 or resid 198 to 212 or resid 218 to 221 or resid 241 to 265 or resid 286 to 316 or resid 331 to 346 or resid 347 to 370)"
	set tm1a "name CA and resid 20 to 31"
	set tm1b "name CA and resid 34 to 44"
	set tm2 "name CA and resid 50 to 75"
	set tm3 "name CA and resid 93 to 124"
	set tm4 "name CA and resid 133 to 148"
	set tm5 "name CA and resid 155 to 178"
	set tm6a "name CA and resid 198 to 212"
	set tm6b "name CA and resid 218 to 221"
	set tm7 "name CA and resid 241 to 265"
	set tm8 "name CA and resid 286 to 316"
	set tm9 "name CA and resid 331 to 346"
	set tm10 "name CA and resid 347 to 370"
	set shift 9
	if { $state == "PRi" } {
		set natoms 7212
		set bb 0
		set Na2 {38 41 42 309 312 313 318 471}
		set S1 {42 117 121 220 314 318 471}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRiBB" } {
		set natoms 7212
		set bb 1
		set Na2 {38 41 42 309 312 313 318 471}
		set S1 {42 117 121 220 314 318 471}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRo" } {
		set natoms 7212
		set bb 0
		set Na2 {38 41 42 309 312 313 318 471}
		set S1 {42 117 121 220 314 318 471}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRoBB" } {
		set natoms 7212
		set bb 1
		set Na2 {38 41 42 309 312 313 318 471}
		set S1 {42 117 121 220 314 318 471}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRoc" } {
		set natoms 7236
		set bb 0
		set Na2 {38 41 42 309 312 313 318 471 472}
		set S1 {42 117 121 220 314 318 471 472}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRocBB" } {
		set natoms 7236
		set bb 1
		set Na2 {38 41 42 309 312 313 318 471 472}
		set S1 {42 117 121 220 314 318 471 472}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
}

### GET SELECTION

set name "protein/selprod.dcd"
set test [file exists $name]
if { $test == 0 } {

	mol new protein/ionized.psf waitfor all
	mol off top
	mol addfile protein/prod.dcd waitfor all
	set mol top
	set numid [expr $numid + 1]

	select $natoms $bb
	sleep 3

	mol delete all
}



### ALIGN USING WEIGHTING ALGORITHM

### GENERATE WEIGHTS FILE

mol new protein/selionized.psf waitfor all
mol off top
mol addfile protein/selprod.dcd type dcd first 0 last -1 step $step waitfor all
set mol top
set numid [expr $numid + 1]

set name "protein/ifitbyres_stride_$step.dat"
set test [file exists $name]
if { $test == 0 } {

	::rmsdtt::rmsdtt
	set ::rmsdtt::bb_only 0
	set ::rmsdtt::trace_only 1
	set ::rmsdtt::noh 0

	set ::rmsdtt::ifit_file "protein/ifitbyres_stride_$step.dat"
	::rmsdtt::iterativeFit
	sleep 3

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
	sleep 3
}

### CREATE NEW PSF FILE WITH COEFFICIENT

set name "protein/selcoefionized.psf"
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
	sleep 30
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
	set numid [expr $numid + 1]

	::rmsdtt::rmsdtt
	set ::rmsdtt::bb_only 0
	set ::rmsdtt::trace_only 1
	set ::rmsdtt::noh 0
	set ::rmsdtt::weighted_sw 1
	set ::rmsdtt::weighted_mol $numid
	set ::rmsdtt::weighted_field "charge"
	::rmsdtt::doAlign

	menu rmsdtt off

	set selall [atomselect top "all"]
	set nf [molinfo top get numframes]
	animate write dcd {protein/selweialiprod.dcd} beg 0 end [expr $nf - 1] waitfor all sel $selall
	sleep 3
}


mol delete all
mol new protein/selweiionized.psf waitfor all
mol off top
mol addfile protein/selweialiprod.dcd waitfor all
set mol top

rmsd [atomselect top $tms frame 0]

distanceall $Na2 $natoms $shift
distanceall $S1 $natoms $shift
distanceall $InGate $natoms $shift
distanceall $OutGate $natoms $shift
if { $prot == "LeuT" } {
	distanceall $Na1 $natoms $shift
	distanceall $S2 $natoms $shift
}

rmsdtm 1a [atomselect top $tm1a frame 0]
rmsdtm 1b [atomselect top $tm1b frame 0]
rmsdtm 2 [atomselect top $tm2 frame 0]
rmsdtm 3 [atomselect top $tm3 frame 0]
rmsdtm 4 [atomselect top $tm4 frame 0]
rmsdtm 5 [atomselect top $tm5 frame 0]
rmsdtm 6a [atomselect top $tm6a frame 0]
rmsdtm 6b [atomselect top $tm6b frame 0]
rmsdtm 7 [atomselect top $tm7 frame 0]
rmsdtm 8 [atomselect top $tm8 frame 0]
rmsdtm 9 [atomselect top $tm9 frame 0]
rmsdtm 10 [atomselect top $tm10 frame 0]

