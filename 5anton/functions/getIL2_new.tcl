set prot [lindex $argv 0]

mol new "$prot\_selweiionized.psf"
mol addfile "$prot\_fixed_long.dcd" first 1 last 1 waitfor all 
set output [open "fit.index" w+]
set output2 [open "atom.vector" w+]
set output3 [open "atom.names" w+]

puts $output3 "A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A"

set sel [atomselect top "all"]
foreach i [$sel get index] {
	set j [expr $i]
	puts $output "$j"
}
$sel delete
set nres 516
for {set i 1} {$i<=$nres} {incr i} {
	puts $i
	set j [atomselect top "protein and resid $i and (not hydrogen)"]
	puts $output2 "[$j num]"
	puts $output3 "[$j get name]"
	puts [$j num]
}

set i 524
puts $i
set j [atomselect top "resid $i and (not hydrogen)"]
puts $output2 "[$j num]"
puts $output3 "[$j get name]"
puts [$j num]

set i 525
puts $i
set j [atomselect top "resid $i and (not hydrogen)"]
puts $output2 "[$j num]"
puts $output3 "[$j get name]"
puts [$j num]

close $output
close $output2
close $output3
