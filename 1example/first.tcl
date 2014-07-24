mol new protein/protein.psf waitfor all
mol addfile protein/protein.dcd waitfor all
set mol top

source functions/distance.tcl

