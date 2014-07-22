#!/bin/bash
# This script finds the core detergent molecules in a protein micelle by selecting based on contact distance. It identifies the core size in findcore.tcl and plots in findcore.R.
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./getIL2.tcl -args $1
