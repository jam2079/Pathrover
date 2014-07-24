source('functions/distanceplot.R')
source('functions/rmsdplot.R')

png<-1

all<-c(5,187,267,268,361,369,29,30,107,111,114,319,320,324,400,404,253,25,105,108,256,259,355,359,254,22,27,286,23,351,354,592,593,514)
prot<-"LeuT"
state<-"PRoc"
alldistanceplot(all,prot,state,png)

set<-"Na1"
site<-c(22,27,254,286,592,593,514)
subset(site,set,prot,state,png)

rmsdplot(prot,state,png)
