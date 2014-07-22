
set prot [lindex $argv 0]

mol new "$prot\_selionized.psf"
mol addfile "$prot\_selweialicatprod.dcd" waitfor all
set nf [molinfo top get numframes]

# Begin loop through all the frames of the trajectory.

set asp [atomselect top "name OD2 and resname ASP"]
set n [$asp num]
set res [$asp get resid]

set sym [open "asp_symmetry.txt" r]
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
			set OD1 [atomselect top "name OD1 and resid $r" frame $f]
			set OD2 [atomselect top "name OD2 and resid $r" frame $f]
			set OD1_c [$OD1 get {x y z}]
			set OD2_c [$OD2 get {x y z}]
			$OD1 moveby [vecsub [lindex $OD2_c 0] [lindex $OD1_c 0]]
			$OD2 moveby [vecsub [lindex $OD1_c 0] [lindex $OD2_c 0]]
			$OD1 delete
			$OD2 delete 
		}

	}
}

set sel [atomselect top "all"]

animate write dcd "$prot\_fixed.dcd" beg 0 end [expr $nf - 1] waitfor all sel $sel

