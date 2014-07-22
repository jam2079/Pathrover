#source parameter.tcl
#set transporter ../5ht_3p

proc dimension {atomselection} {
	set minmax [measure minmax $atomselection]
	set min [lindex $minmax 0]
	set max [lindex $minmax 1]
	puts "x [expr [lindex $max 0] - [lindex $min 0]]"
	puts "y [expr [lindex $max 1] - [lindex $min 1]]"
	puts "z [expr [lindex $max 2] - [lindex $min 2]]"
	set centercoor [measure center $atomselection]
	set x [lindex $centercoor 0]
	set y [lindex $centercoor 1]
	set z [lindex $centercoor 2]
	
	puts "center [format "%.3f %.3f %.3f" $x $y $z]"
}


set everyone [atomselect top all]
dimension $everyone
	
#set protein [atomselect 0 "segid PROT LIG"]
#dimension $protein

x 169.3679962158203
y 176.4959945678711
z 93.04000091552734
center 39.571 42.926 -0.222

