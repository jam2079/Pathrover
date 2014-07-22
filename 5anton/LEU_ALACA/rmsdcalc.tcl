
source rmsd.tcl

set prot [lindex $argv 0]

if { $prot == "LEU" } {
	set tms "name CA and (resid 11 to 22 or resid 25 to 38 or resid 41 to 72 or resid 88 to 124 or resid 166 to 185 or resid 191 to 215 or resid 241 to 255 or resid 261 to 267 or resid 275 to 306 or resid 337 to 370 or resid 375 to 394 or resid 399 to 425 or resid 446 to 476 or resid 481 to 512)"
	set tm1a "name CA and resid 11 to 22"
	set tm1b "name CA and resid 25 to 38"
	set tm2 "name CA and resid 41 to 72"
	set tm3 "name CA and resid 88 to 124"
	set tm4 "name CA and resid 166 to 185"
	set tm5 "name CA and resid 191 to 215"
	set tm6a "name CA and resid 241 to 255"
	set tm6b "name CA and resid 261 to 267"
	set tm7 "name CA and resid 275 to 306"
	set tm8 "name CA and resid 337 to 370"
	set tm9 "name CA and resid 375 to 394"
	set tm10 "name CA and resid 399 to 425"
	set tm11 "name CA and resid 446 to 476"
	set tm12 "name CA and resid 481 to 512"
}
if { $prot == "LEU_VAL" } {
	set tms "name CA and (resid 11 to 22 or resid 29 to 38 or resid 41 to 72 or resid 88 to 124 or resid 166 to 184 or resid 191 to 215 or resid 241 to 255 or resid 261 to 267 or resid 275 to 306 or resid 337 to 370 or resid 375 to 394 or resid 399 to 425 or resid 446 to 476 or resid 481 to 511)"
	set tm1a "name CA and resid 11 to 22"
	set tm1b "name CA and resid 29 to 38"
	set tm2 "name CA and resid 41 to 72"
	set tm3 "name CA and resid 88 to 124"
	set tm4 "name CA and resid 166 to 184"
	set tm5 "name CA and resid 191 to 215"
	set tm6a "name CA and resid 241 to 255"
	set tm6b "name CA and resid 261 to 267"
	set tm7 "name CA and resid 275 to 306"
	set tm8 "name CA and resid 337 to 370"
	set tm9 "name CA and resid 375 to 394"
	set tm10 "name CA and resid 399 to 425"
	set tm11 "name CA and resid 446 to 476"
	set tm12 "name CA and resid 481 to 511"
}
if { $prot == "LEU_ALA" } {
	set tms "name CA and (resid 11 to 22 or resid 29 to 38 or resid 41 to 72 or resid 88 to 124 or resid 166 to 185 or resid 191 to 215 or resid 241 to 255 or resid 261 to 268 or resid 275 to 306 or resid 337 to 371 or resid 375 to 395 or resid 399 to 425 or resid 446 to 476 or resid 481 to 511)"
	set tm1a "name CA and resid 11 to 22"
	set tm1b "name CA and resid 29 to 38"
	set tm2 "name CA and resid 41 to 72"
	set tm3 "name CA and resid 88 to 124"
	set tm4 "name CA and resid 166 to 185"
	set tm5 "name CA and resid 191 to 215"
	set tm6a "name CA and resid 241 to 255"
	set tm6b "name CA and resid 261 to 268"
	set tm7 "name CA and resid 275 to 306"
	set tm8 "name CA and resid 337 to 371"
	set tm9 "name CA and resid 375 to 395"
	set tm10 "name CA and resid 399 to 425"
	set tm11 "name CA and resid 446 to 476"
	set tm12 "name CA and resid 481 to 511"
}

if { $prot == "ALA" } {
	set tms "name CA and (resid 11 to 22 or resid 29 to 38 or resid 41 to 72 or resid 88 to 124 or resid 166 to 185 or resid 191 to 215 or resid 241 to 255 or resid 261 to 267 or resid 275 to 306 or resid 337 to 370 or resid 375 to 395 or resid 399 to 425 or resid 446 to 476 or resid 481 to 511)"
	set tm1a "name CA and resid 11 to 22"
	set tm1b "name CA and resid 29 to 38"
	set tm2 "name CA and resid 41 to 72"
	set tm3 "name CA and resid 88 to 124"
	set tm4 "name CA and resid 166 to 185"
	set tm5 "name CA and resid 191 to 215"
	set tm6a "name CA and resid 241 to 255"
	set tm6b "name CA and resid 261 to 267"
	set tm7 "name CA and resid 275 to 306"
	set tm8 "name CA and resid 337 to 370"
	set tm9 "name CA and resid 375 to 395"
	set tm10 "name CA and resid 399 to 425"
	set tm11 "name CA and resid 446 to 476"
	set tm12 "name CA and resid 481 to 511"
}

mol new "$prot\_selweiionized.psf" waitfor all
mol off top
mol addfile "$prot\_selweialiprod.dcd" waitfor all
set mol top

rmsd [atomselect top $tms frame 0] $prot

rmsdtm 1a [atomselect top $tm1a frame 0] $prot
rmsdtm 1b [atomselect top $tm1b frame 0] $prot
rmsdtm 2 [atomselect top $tm2 frame 0] $prot
rmsdtm 3 [atomselect top $tm3 frame 0] $prot
rmsdtm 4 [atomselect top $tm4 frame 0] $prot
rmsdtm 5 [atomselect top $tm5 frame 0] $prot
rmsdtm 6a [atomselect top $tm6a frame 0] $prot
rmsdtm 6b [atomselect top $tm6b frame 0] $prot
rmsdtm 7 [atomselect top $tm7 frame 0] $prot
rmsdtm 8 [atomselect top $tm8 frame 0] $prot
rmsdtm 9 [atomselect top $tm9 frame 0] $prot
rmsdtm 10 [atomselect top $tm10 frame 0] $prot
rmsdtm 11 [atomselect top $tm11 frame 0] $prot
rmsdtm 12 [atomselect top $tm12 frame 0] $prot


