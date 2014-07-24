args <- commandArgs(TRUE)
prot <- args[1]
run <- args[2]
set <- args[3]

window <- 5
sites <- c("EV","EV2","IV","IV2")

require(zoo)
path <- paste("../../watercounts/")

for (site in sites) {
for (i in 0:20) {
    if (site=="EV") {lim <- 100}
    if (site=="EV2") {lim <- 20}
    if (site=="IV") {lim <- 50}
    if (site=="IV2") {lim <- 10}
    if (site=="EV") {window <- 5}
    if (site=="EV2") {window <- 5}
    if (site=="IV") {window <- 5}
    if (site=="IV2") {window <- 5}
    pngfile<-paste(path,"set",set,"/plots/waterbasiccounts_",prot,"_",site,"_run",run,"_filter",i,".png",sep="")
    datfile<-paste(path,"set",set,"/data/waterbasiccounts_",prot,"_",site,"_run",run,"_filter",i,".dat",sep="")
    if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
    a <- read.table(datfile)
    a <- as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",ylim=c(0,lim),xlab="Frame",ylab="Water count",main=paste("Water count",prot,"site",site,"run",run,"filter",i))
    dev.off()
    rm(a)
    }
}
}

window <- 9
path <- paste("../../distances/")
set<-"S2"
res<-c(84,85,155,159,162,217,221,222,385,386,387,391,415,469,472,473,476)
for (r1 in res){
    for (r2 in res) {if (r1 < r2){
        pngfile<-paste(path,"plots/distance_",prot,"_run",run,"_",r1,"_",r2,".png",sep="")
        datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_",r2,".dat",sep="")
        if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
            a<-read.table(datfile)
            a<-as.vector(as.matrix(a))
            a <- rollmean(a,window)
            png(pngfile,width=1100,height=825,res=160)
            plot((1:length(a))-1,a,"l",main=paste(prot," run ",run," distance ",r1," ",r2,". Site: ",set,sep=""),xlab="Frame", ylab="Distance")
            dev.off()
        }
    }}
}

r1<-"Na"
r2<-"Na"
pngfile<-paste(path,"plots/distance_",prot,"_run",run,"_",r1,"_",r2,".png",sep="")
datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_",r2,".dat",sep="")
if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot," run ",run," distance ",r1," ",r2,sep=""),xlab="Frame", ylab="Distance")
    dev.off()
}
pngfile<-paste(path,"plots/distance_",prot,"_run",run,"_",r1,"_",r2,"_tri.png",sep="")
datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_",r2,"_tri.dat",sep="")
if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot," run ",run," average distance Na2 triangle Cl-Na1",sep=""),xlab="Frame", ylab="Distance")
    dev.off()
}
pngfile<-paste(path,"plots/distance_",prot,"_run",run,"_",r1,"_",r2,"_tri_ang.png",sep="")
datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_",r2,"_tri_ang.dat",sep="")
if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot," run ",run," average angle Na2-Cl Na2-Na1",sep=""),xlab="Frame", ylab="Angle")
    dev.off()
}
pngfile<-paste(path,"plots/distance_",prot,"_run",run,"_",r1,"_",r2,"_nearest.png",sep="")
datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_",r2,"_nearest.dat",sep="")
if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot," run ",run," distance ",r1," nearest ",r2,sep=""),xlab="Frame", ylab="Distance")
    dev.off()
}
