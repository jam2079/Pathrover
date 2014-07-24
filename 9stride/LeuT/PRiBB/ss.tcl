
set prot [lindex $argv 0]
set state [lindex $argv 1]

mol load psf "protein/selweiionized.psf" dcd "protein/fixed.dcd"

set nf [molinfo top get numframes]
set outfile [open "../../strs/$prot\_$state\_str.dat" a]; 
set protCA [atomselect 0 "protein and name CA"]

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

exit

