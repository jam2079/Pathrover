
set prot [lindex $argv 0]

mol new "$prot\_selionized.psf"
mol addfile "$prot\_selweialiprod.dcd" waitfor all
set nf [molinfo top get numframes]

# Begin loop through all the frames of the trajectory.

set glu [atomselect top "name OE2 and resname GLU"]
set n [$glu num]
set res [$glu get resid]

set sym [open "glu_symmetry_long.txt" r]
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
			set OE1 [atomselect top "name OE1 and resid $r" frame $f]
			set OE2 [atomselect top "name OE2 and resid $r" frame $f]
			set OE1_c [$OE1 get {x y z}]
			set OE2_c [$OE2 get {x y z}]
			$OE1 moveby [vecsub [lindex $OE2_c 0] [lindex $OE1_c 0]]
			$OE2 moveby [vecsub [lindex $OE1_c 0] [lindex $OE2_c 0]]
			$OE1 delete
			$OE2 delete 
		}

	}
}

set sel [atomselect top "all"]

animate write dcd "$prot\_fixed_long.dcd" beg 0 end [expr $nf - 1] waitfor all sel $sel

