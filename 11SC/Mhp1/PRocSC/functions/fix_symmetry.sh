#!/bin/bash
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./measureALL_SYM.tcl > measureALL_SYM.log
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/R CMD BATCH ./find.all.states.2.R
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixPHE.tcl > fixPHE.log
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixGLU.tcl > fixGLU.log
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixASP.tcl > fixASP.log
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixARG.tcl > fixARG.log
