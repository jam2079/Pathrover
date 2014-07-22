setwd("Mhp1/PRoc")

source('functions/distanceplot.R')
source('functions/rmsdplot.R')

png<-1
pdf<-0

prot<-"Mhp1"
state<-"PRoc"

set<-"Na2"
res<-c(38,41,42,309,312,313,318,471,472)
alldistanceplot(res,prot,state,set,png,pdf)

set<-"S1"
res<-c(42,117,121,220,314,318,471,472)
alldistanceplot(res,prot,state,set,png,pdf)

set<-"InGate"
res<-c(161,162,163,229,230,231)
alldistanceplot(res,prot,state,set,png,pdf)

set<-"OutGate"
res<-c(47,48,49,220,360,361,362)
alldistanceplot(res,prot,state,set,png,pdf)

rmsdplot(prot,state,png,pdf)

setwd("../..")
