set prot [lindex $argv 0]

mol new selionized.psf
mol addfile fixed.dcd first 1 last 1 waitfor all 
set output [open "fit.index" w+]
set output2 [open "atom.vector" w+]
set output3 [open "glycines.dat" w+]
set sel [atomselect top "all"]
foreach i [$sel get index] {
	set j [expr $i]
	puts $output "$j"
}
$sel delete
set sel [atomselect top "all"]
set all [$sel get resid]
set ord [lsort -integer $all]
set rev [lreverse $ord]
set nres [lindex $rev 0]
#puts $prot
#if {$prot == "LeuT"} {set nres 513}
if {$prot == "Mhp1"} {set nres 461}
for {set i 1} {$i<=$nres} {incr i} {
	puts $i
	set j [atomselect top "resid $i and (not hydrogen)"]
	puts $output2 "[$j num]"
	puts [$j num]
	if {[$j num] == 0} {puts $output3 "$i"}
}
close $output
close $output2
