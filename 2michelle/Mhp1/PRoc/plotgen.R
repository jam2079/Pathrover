source('functions/distanceplot.R')
source('functions/rmsdplot.R')

png<-1

all<-c(117,220,318,121,314,42,355,360,365,370,38,41,309,312,313,263,462,463)
prot<-"Mhp1"
state<-"PRoc"
alldistanceplot(all,prot,state,png)

set<-"Na1"
site<-c(38,41,309,312,313,318,42,462,463)
subset(site,set,prot,state,png)

rmsdplot(prot,state,png)
