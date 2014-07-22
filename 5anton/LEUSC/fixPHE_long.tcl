
set prot [lindex $argv 0]

mol new "$prot\_selionized.psf"
mol addfile "$prot\_selweialiprod.dcd" waitfor all
set nf [molinfo top get numframes]

# Begin loop through all the frames of the trajectory.

set phe [atomselect top "name CA and (resname PHE or resname TYR)"]
set n [$phe num]
set res [$phe get resid]

set sym [open "phe_symmetry_long.txt" r]
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
			set CD1 [atomselect top "name CD1 and resid $r" frame $f]
			set CE1 [atomselect top "name CE1 and resid $r" frame $f]
			set CD2 [atomselect top "name CD2 and resid $r" frame $f]
			set CE2 [atomselect top "name CE2 and resid $r" frame $f]
			set CD1_c [$CD1 get {x y z}]
			set CD2_c [$CD2 get {x y z}]
			set CE1_c [$CE1 get {x y z}]
			set CE2_c [$CE2 get {x y z}]
			$CD1 moveby [vecsub [lindex $CD2_c 0] [lindex $CD1_c 0]]
			$CD2 moveby [vecsub [lindex $CD1_c 0] [lindex $CD2_c 0]]
			$CE1 moveby [vecsub [lindex $CE2_c 0] [lindex $CE1_c 0]]
			$CE2 moveby [vecsub [lindex $CE1_c 0] [lindex $CE2_c 0]]
			$CD1 delete
			$CD2 delete
			$CE1 delete
			$CE2 delete 
		}

	}
}

set sel [atomselect top "all"]

animate write dcd "$prot\_fixed_long.dcd" beg 0 end [expr $nf - 1] waitfor all sel $sel

