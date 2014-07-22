#!/bin/bash
prot=$1
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./measureALL_SYM.tcl > vmdmeasureALL_SYM.log -args $prot
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/R CMD BATCH ./find.all.states.2.R
#/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript find.all.states.2.R
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixPHE.tcl > vmdfixPHE.log -args $prot
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixGLU.tcl > vmdfixGLU.log -args $prot
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixASP.tcl > vmdfixASP.log -args $prot
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixARG.tcl > vmdfixARG.log -args $prot
