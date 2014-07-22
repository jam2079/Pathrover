set i [lindex $argv 0]

package require psfgen
topology top_all36_lipid.rtf

#for {set i 1} {$i <=18} {incr i} {

#set i 1

puts "lolailo"
puts $i


#topology top_build_sgm2.inp
mol load water$i\.pdb

segment WT$i {pdb water$i\.pdb}
coordpdb water$i\.pdb WT$i

regenerate dihedrals angles
guesscoord

writepsf water_temp$i\.psf
writepdb water_temp$i\.pdb

#}

exit
