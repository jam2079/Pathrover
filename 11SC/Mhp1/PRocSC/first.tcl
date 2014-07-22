
source functions/select.tcl

set prot [lindex $argv 0]
set state [lindex $argv 1]
set step 10
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
		set SC 0
		set Na1 {22 27 254 286 515}
		set Na2 {20 23 351 354 355 514}
		set S1 {25 26 104 108 253 254 256 259 355 359 515}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRiSC" } {
		set natoms 8244
		set SC 1
		set Na1 {22 27 254 286 515}
		set Na2 {20 23 351 354 355 514}
		set S1 {25 26 104 108 253 254 256 259 355 359 515}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRo" } {
		set natoms 8244
		set SC 0
		set Na1 {22 27 254 286 593}
		set Na2 {20 23 351 354 355 592}
		set S1 {25 26 104 108 253 254 256 259 355 359 593}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRoSC" } {
		set natoms 8244
		set SC 1
		set Na1 {22 27 254 286 593}
		set Na2 {20 23 351 354 355 592}
		set S1 {25 26 104 108 253 254 256 259 355 359 593}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRoc" } {
		set natoms 8266
		set SC 0
		set Na1 {22 27 254 286 593 514}
		set Na2 {20 23 351 354 355 592}
		set S1 {25 26 104 108 253 254 256 259 355 359 593 514}
		set S2 {29 30 107 111 114 253 319 320 324 400 404}
		set InGate {5 187 267 268 361 369}
		set OutGate {30 108 250 253 404}
	}
	if { $state == "PRocSC" } {
		set natoms 8266
		set SC 1
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
		set SC 0
		set Na2 {38 41 42 309 312 313 318 471}
		set S1 {42 117 121 220 314 318 471}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRiSC" } {
		set natoms 7212
		set SC 1
		set Na2 {38 41 42 309 312 313 318 471}
		set S1 {42 117 121 220 314 318 471}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRo" } {
		set natoms 7212
		set SC 0
		set Na2 {38 41 42 309 312 313 318 471}
		set S1 {42 117 121 220 314 318 471}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRoSC" } {
		set natoms 7212
		set SC 1
		set Na2 {38 41 42 309 312 313 318 471}
		set S1 {42 117 121 220 314 318 471}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRoc" } {
		set natoms 7236
		set SC 0
		set Na2 {38 41 42 309 312 313 318 471 472}
		set S1 {42 117 121 220 314 318 471 472}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
	if { $state == "PRocSC" } {
		set natoms 7236
		set SC 1
		set Na2 {38 41 42 309 312 313 318 471 472}
		set S1 {42 117 121 220 314 318 471 472}
		set InGate {161 162 163 229 230 231}
		set OutGate {47 48 49 220 360 361 362}
	}
}

### GET SELECTION

set name "protein/out.dcd"
set test [file exists $name]
if { $test == 0 } {

	mol new protein/selweiionized.psf waitfor all
	mol off top
	mol addfile protein/fixed.dcd waitfor all
	set mol top

	select $natoms $SC
	sleep 3

	mol delete all
}


