source functions/distance.tcl
source functions/rmsd.tcl
source functions/select.tcl

set name "protein/selionized.psf"
set test [file exists $name]
if { $test == 0 } {

	mol new protein/ionized.psf waitfor all
	mol addfile protein/prod.dcd waitfor all
	set mol top

	select 7212

	mol delete all
}

mol new protein/selionized.psf waitfor all
mol addfile protein/selprod.dcd waitfor all
set mol top

distanceall {117 220 318 121 314 42 355 360 365 370 38 41 309 312 313 263 462} 7212

rmsd [atomselect top "name CA and (resid 23 to 38 or resid 42 to 53 or resid 59 to 86 or resid 102 to 135 or resid 141 to 159 or resid 161 to 190 or resid 209 to 218 or resid 222 to 232 or resid 243 to 274 or resid 296 to 330 or resid 335 to 357 or resid 359 to 388)" frame 0]

