source functions/distance.tcl
source functions/rmsd.tcl
source functions/select.tcl

set name "protein/selionized.psf"
set test [file exists $name]
if { $test == 0 } {

	mol new protein/ionized.psf waitfor all
	mol addfile protein/prod.dcd waitfor all
	set mol top

	select 8244

	mol delete all
}

mol new protein/selionized.psf waitfor all
mol addfile protein/selprod.dcd waitfor all
set mol top

distanceall {5 187 267 268 361 369 29 30 107 111 114 319 320 324 400 404 253 25 105 108 256 259 355 359 254 22 27 286 23 351 354 592 593} 8244

rmsd [atomselect top "name CA and (resid 11 to 22 or resid 25 to 37 or resid 41 to 70 or resid 88 to 124 or resid 166 to 183 or resid 191 to 213 or resid 241 to 255 or resid 261 to 266 or resid 276 to 306 or resid 337 to 369 or resid 375 to 395 or resid 399 to 424)" frame 0]

