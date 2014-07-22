#!/bin/bash
prot=$1
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./measureALL_SYM_long.tcl > vmdmeasureALL_SYM_long.log -args $prot
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/R CMD BATCH ./find.all.states.2_long.R
#/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript find.all.states.2.R
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixPHE_long.tcl > vmdfixPHE_long.log -args $prot
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixGLU_long.tcl > vmdfixGLU_long.log -args $prot
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixASP_long.tcl > vmdfixASP_long.log -args $prot
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixARG_long.tcl > vmdfixARG_long.log -args $prot
