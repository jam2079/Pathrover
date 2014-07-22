
set prot [lindex $argv 0]

mol new "$prot\_selionized.psf"
mol addfile "$prot\_selweialicatprod.dcd" waitfor all
set nf [molinfo top get numframes]

# Begin loop through all the frames of the trajectory.

set arg [atomselect top "name CA and resname ARG"]
set n [$arg num]
set res [$arg get resid]

set sym [open "arg_symmetry.txt" r]
set rowslst [split [read $sym] "\n"]
close $sym
set i 0
foreach rw $rowslst {
	set elmlst [split $rw " "];
	set j 0
	foreach elm $elmlst {
		set A($i,$j) $elm;
		incr j
	}
	incr i
}

for {set f 0} {$f < $nf} {set f [expr $f + 1]} {
	for {set i 0} {$i < $n} {set i [expr $i + 1]} {
		if {$A($f,$i)==2} {
			set r [lindex $res $i]
			set NH1 [atomselect top "name NH1 and resid $r" frame $f]
			set NH2 [atomselect top "name NH2 and resid $r" frame $f]
			set NH1_c [$NH1 get {x y z}]
			set NH2_c [$NH2 get {x y z}]
			$NH1 moveby [vecsub [lindex $NH2_c 0] [lindex $NH1_c 0]]
			$NH2 moveby [vecsub [lindex $NH1_c 0] [lindex $NH2_c 0]]
			$NH1 delete
			$NH2 delete 
		}

	}
}

set sel [atomselect top "all"]

animate write dcd "$prot\_fixed.dcd" beg 0 end [expr $nf - 1] waitfor all sel $sel

