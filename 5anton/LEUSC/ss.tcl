
set prot [lindex $argv 0]

set name "../strs/tmp/$prot\_str_tmp.dat"
set test [file exists $name]
if { $test == 0 } {

	mol load psf "$prot\_selweiionized.psf" dcd "$prot\_fixed.dcd"

	set nf [molinfo top get numframes]
	set outfile [open $name a]; 
	set protCA [atomselect 0 "alpha"]

	for {set j 0} {$j < $nf } { incr j } {   

	    animate goto $j  
	    display update ui  
	    mol ssrecalc 0    
	    $protCA frame $j  
	    $protCA update  
	    set sscache_data($j) [$protCA get structure]  
	    puts $outfile $sscache_data($j)  
	}   
	mol delete all   
	close $outfile   
}

exit

