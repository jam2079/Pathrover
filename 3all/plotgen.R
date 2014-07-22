args <- commandArgs(TRUE)
prot<-args[1]
state<-args[2]

source('functions/distanceplot.R')
source('functions/rmsdplot.R')
require(zoo)

png<-1
pdf<-0


if (prot=="LeuT") {
    set<-"Na1"
    if ((state == "PRi") || (state == "PRiBB")) {res<-c(22,27,254,286,515)}
    if ((state == "PRo") || (state == "PRoBB")) {res<-c(22,27,254,286,593)}
    if ((state == "PRoc")|| (state == "PRocBB")){res<-c(22,27,254,286,593,514)}
    alldistanceplot(res,prot,state,set,png,pdf)
}

set<-"Na2"
if ((prot == "LeuT") && ((state == "PRi") || (state == "PRiBB"))) {res<-c(20,23,351,354,355,514)}
if ((prot == "LeuT") && ((state == "PRo") || (state == "PRoBB"))) {res<-c(20,23,351,354,355,592)}
if ((prot == "LeuT") && ((state == "PRoc")|| (state == "PRocBB"))){res<-c(20,23,351,354,355,592)}
if ((prot == "Mhp1") && ((state == "PRi") || (state == "PRiBB"))) {res<-c(38,41,42,309,312,313,318,471)}
if ((prot == "Mhp1") && ((state == "PRo") || (state == "PRoBB"))) {res<-c(38,41,42,309,312,313,318,471)}
if ((prot == "Mhp1") && ((state == "PRoc")|| (state == "PRocBB"))){res<-c(38,41,42,309,312,313,318,471,472)}
alldistanceplot(res,prot,state,set,png,pdf)

set<-"S1"
if ((prot == "LeuT") && ((state == "PRi") || (state == "PRiBB"))) {res<-c(25,26,104,108,253,254,256,259,355,359,515)}
if ((prot == "LeuT") && ((state == "PRo") || (state == "PRoBB"))) {res<-c(25,26,104,108,253,254,256,259,355,359,593)}
if ((prot == "LeuT") && ((state == "PRoc")|| (state == "PRocBB"))){res<-c(25,26,104,108,253,254,256,259,355,359,593,514)}
if ((prot == "Mhp1") && ((state == "PRi") || (state == "PRiBB"))) {res<-c(42,117,121,220,314,318,471)}
if ((prot == "Mhp1") && ((state == "PRo") || (state == "PRoBB"))) {res<-c(42,117,121,220,314,318,471)}
if ((prot == "Mhp1") && ((state == "PRoc")|| (state == "PRocBB"))){res<-c(42,117,121,220,314,318,471,472)}
alldistanceplot(res,prot,state,set,png,pdf)

if (prot=="LeuT") {
    set<-"S2"
    if ((state == "PRi") || (state == "PRiBB")) {res<-c(29,30,107,111,114,253,319,320,324,400,404)}
    if ((state == "PRo") || (state == "PRoBB")) {res<-c(29,30,107,111,114,253,319,320,324,400,404)}
    if ((state == "PRoc")|| (state == "PRocBB")){res<-c(29,30,107,111,114,253,319,320,324,400,404)}
    alldistanceplot(res,prot,state,set,png,pdf)
}

set<-"InGate"
if ((prot == "LeuT") && ((state == "PRi") || (state == "PRiBB"))) {res<-c(5,187,267,268,361,369)}
if ((prot == "LeuT") && ((state == "PRo") || (state == "PRoBB"))) {res<-c(5,187,267,268,361,369)}
if ((prot == "LeuT") && ((state == "PRoc")|| (state == "PRocBB"))){res<-c(5,187,267,268,361,369)}
if ((prot == "Mhp1") && ((state == "PRi") || (state == "PRiBB"))) {res<-c(161,162,163,229,230,231)}
if ((prot == "Mhp1") && ((state == "PRo") || (state == "PRoBB"))) {res<-c(161,162,163,229,230,231)}
if ((prot == "Mhp1") && ((state == "PRoc")|| (state == "PRocBB"))){res<-c(161,162,163,229,230,231)}
alldistanceplot(res,prot,state,set,png,pdf)

set<-"OutGate"
if ((prot == "LeuT") && ((state == "PRi") || (state == "PRiBB"))) {res<-c(30,108,250,253,404)}
if ((prot == "LeuT") && ((state == "PRo") || (state == "PRoBB"))) {res<-c(30,108,250,253,404)}
if ((prot == "LeuT") && ((state == "PRoc")|| (state == "PRocBB"))){res<-c(30,108,250,253,404)}
if ((prot == "Mhp1") && ((state == "PRi") || (state == "PRiBB"))) {res<-c(47,48,49,220,360,361,362)}
if ((prot == "Mhp1") && ((state == "PRo") || (state == "PRoBB"))) {res<-c(47,48,49,220,360,361,362)}
if ((prot == "Mhp1") && ((state == "PRoc")|| (state == "PRocBB"))){res<-c(47,48,49,220,360,361,362)}
alldistanceplot(res,prot,state,set,png,pdf)

rmsdplot(prot,state,png,pdf)

