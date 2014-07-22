package require psfgen
topology top_all36_lipid.rtf

set i [lindex $argv 0]


readpsf combined_protmembwater.psf
coordpdb combined_protmembwater.pdb

#for {set i 1} {$i <= 18} {incr i} {
readpsf water_temp$i\.psf
coordpdb water_temp$i\.pdb
#}

writepsf combined_protmembwater.psf
writepdb combined_protmembwater.pdb

exit
