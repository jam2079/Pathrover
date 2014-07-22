
proc linecount {file} {
        set i 0
        set fid [open $file r]
        while {[gets $fid line] > -1} {incr i}
        close $fid
        return $i
}

set prot [lindex $argv 0]
set n [lindex $argv 1]

mol new "$prot\_selweiionized.psf" waitfor all
mol off top
mol addfile "$prot\_fixed_long.dcd" type dcd first [expr 100*$n] last [expr 100*$n+100] waitfor all

set nf [molinfo top get numframes]
#set nf 100

for {set i 0} {$i < [expr $nf - 1]} {incr i} {
	set c [expr 100*$n + $i]

	set f0 [atomselect top "all" frame $i]
	set filename "frame$i\.pdb"
	$f0 writepdb $filename
	set tmpname "tmp$i\.pdb"

	set source [open $filename]
	set destination [open $tmpname w]
	set content [read $source]
	close $source

	set l [linecount $filename]
	set l [expr $l - 1]

	set lines [split $content \n]
	set lines_after_deletion [lreplace $lines $l $l]
	puts -nonewline $destination [join $lines_after_deletion \n]
	close $destination

	file rename -force $tmpname $filename

	set j [expr $i +1]	
	set f0 [atomselect top "all" frame $j]
	set filename "frame$j\.pdb"
	$f0 writepdb $filename
	set tmpname "tmp$j\.pdb"

	set source [open $filename]
	set destination [open $tmpname w]
	set content [read $source]
	close $source

	set l 0

	set lines [split $content \n]
	set lines_after_deletion [lreplace $lines $l $l]
	puts -nonewline $destination [join $lines_after_deletion \n]
	close $destination

	file rename -force $tmpname $filename
	
	set filenamei "frame$i\.pdb"
	set source [open $filenamei]
	set contenti [read $source]
	close $source

	set filenamej "frame$j\.pdb"
	set source [open $filenamej]
	set contentj [read $source]
	close $source

	set c [expr 100*$n + $i]
	set destination [open "dcd$c\.pdb" w]
	puts -nonewline $destination $contenti
	puts -nonewline $destination $contentj
	close $destination
	
	if { $n == 0 } {
		if { $i == 0 } {
			file copy "dcd0.pdb" "$prot\_transfer.pdb"
		}
	}	
	file delete "frame$i\.pdb"
	file delete "frame$j\.pdb"
}
	



#for {set i 0} { $i < 100} { incr i } {
#	set j [expr $i + 1]
#	set f0 [atomselect top "all" frame $i]
#	set f1 [atomselect top "all" frame $j]
#	$f0 writepdb frame$i\.pdb
#	$f1 writepdb frame$j\.pdb
#}
exit

