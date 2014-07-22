rm(list=ls())
prot <- "LeuT"
if(prot=="LeuT"){
    nres <- 513
    TM1<-c(11:37)
    TM2<-c(41:70)
    TM3<-c(88:124)
    TM4<-c(166:183)
    TM5<-c(191:213)
    TM6<-c(241:266)
    TM7<-c(276:306)
    TM8<-c(337:369)
    TM9<-c(375:395)
    TM10<-c(399:424)
    TM11<-c(447:477)
    TM12<-c(483:513)
    IL1<-c(77:84)
    EL2<-c(137:152)
    EL3<-c(223:231)
    EL4<-c(308:331)
    IL5<-c(429:437)
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10)
    eTM <- list(TM11,TM12)
    eL <- list(IL1,EL2,EL3,EL4,IL5)
}
if(prot=="Mhp1"){nres <- 461}
state <- "PRocBB"
plt <- "rigvsrmsf"
#plt <- "coef"
#plt <- "both"
ncov <- 10
window <- 7
smooth <- 1
zones <- 1
sequence <- 1
minres <- window
maxres <- nres-window+1
all <- c(minres:maxres)
sel <- c(TM1)
sel <- c(all)


require(fields)
require(gplots)
require(calibrate)
require(zoo)
natemp <- c(1:nres)
natemp[] <- NA

dev <- as.matrix(read.table(paste(prot,"/",state,"/",ncov,"_1_KINK_AVE_DEV_TCI.dat",sep="")))
mindev <- min(dev)
maxdev <- max(dev)
rig <- as.matrix(read.table(paste(prot,"/",state,"/",ncov,"_1_KINK_AVE_R_TCI",window,".dat",sep="")))
rig <- rig[seq(1,length(rig),by=2)]
minrig <- min(rig)
maxrig <- max(rig)

rescodes<-c("M","E","V","K","R","E","H","W","A","T","R","L","G","L","I","L","A","M","A","G","N","A","V","G","L","G","N","F","L","R","F","P","V","Q","A","A","E","N","G","G","G","A","F","M","I","P","Y","I","I","A","F","L","L","V","G","I","P","L","M","W","I","E","W","A","M","G","R","Y","G","G","A","Q","G","H","G","T","T","P","A","I","F","Y","L","L","W","R","N","R","F","A","K","I","L","G","V","F","G","L","W","I","P","L","V","V","A","I","Y","Y","V","Y","I","E","S","W","T","L","G","F","A","I","K","F","L","V","G","L","V","P","E","P","P","P","N","A","T","D","P","D","S","I","L","R","P","F","K","E","F","L","Y","S","Y","I","G","V","P","K","G","D","E","P","I","L","K","P","S","L","F","A","Y","I","V","F","L","I","T","M","F","I","N","V","S","I","L","I","R","G","I","S","K","G","I","E","R","F","A","K","I","A","M","P","T","L","F","I","L","A","V","F","L","V","I","R","V","F","L","L","E","T","P","N","G","T","A","A","D","G","L","N","F","L","W","T","P","D","F","E","K","L","K","D","P","G","V","W","I","A","A","V","G","Q","I","F","F","T","L","S","L","G","F","G","A","I","I","T","Y","A","S","Y","V","R","K","D","Q","D","I","V","L","S","G","L","T","A","A","T","L","N","E","K","A","E","V","I","L","G","G","S","I","S","I","P","A","A","V","A","F","F","G","V","A","N","A","V","A","I","A","K","A","G","A","F","N","L","G","F","I","T","L","P","A","I","F","S","Q","T","A","G","G","T","F","L","G","F","L","W","F","F","L","L","F","F","A","G","L","T","S","S","I","A","I","M","Q","P","M","I","A","F","L","E","D","E","L","K","L","S","R","K","H","A","V","L","W","T","A","A","I","V","F","F","S","A","H","L","V","M","F","L","N","K","S","L","D","E","M","D","F","W","A","G","T","I","G","V","V","F","F","G","L","T","E","L","I","I","F","F","W","I","F","G","A","D","K","A","W","E","E","I","N","R","G","G","I","I","K","V","P","R","I","Y","Y","Y","V","M","R","Y","I","T","P","A","F","L","A","V","L","L","V","V","W","A","R","E","Y","I","P","K","I","M","E","E","T","H","W","T","V","W","I","T","R","F","Y","I","I","G","L","F","L","F","L","T","F","L","V","F","L","A","E","R","R","R","N","H","E","S","A","G","T","L","V","P","R")
rescodes<-rescodes[1:nres]
reslabels<-paste(rescodes,c(1:nres),sep="")

yrig <- rollmean(rig,window,align="left",fill=NA)
nafill <- natemp[1:(window-1)]
yrig <- c(nafill,yrig)

rmsf <- natemp
xrmsf <- natemp
for (i in 1:nres) {
    rmsf[i] <- sqrt(sum(dev[(4*(i-1)+1):(4*i)]^2))
}
xrmsf[all] <- rmsf[all]

coef <- yrig/xrmsf
smoothall <- natemp
smoothall[all] <- rollmean(all,smooth,fill=NA)
smoothcoef <- natemp
smoothcoef[all] <- rollmean(coef[all],smooth,fill=NA)

if (plt=="rigvsrmsf") {
    #plot(xrmsf[sel],yrig[sel],"l",xlim=c(min(xrmsf[all]),max(1.02*xrmsf[all])),ylim=c(min(yrig[all]),max(yrig[all])),col="blue",main=paste(window,"-info vs RMSF ",prot," ",state,sep=""),ylab=paste(window,"-info",sep=""),xlab="RMSF")
    plot(xrmsf[sel],yrig[sel],xlim=c(min(xrmsf[all]),max(1.02*xrmsf[all])),ylim=c(min(yrig[all]),max(yrig[all])),col="white",main=paste(window,"-info vs RMSF ",prot," ",state,sep=""),ylab=paste(window,"-info",sep=""),xlab="RMSF")
    used <- c()
    for (i in 1:10) {
        seltm <- intersect(sel,TM[[i]])
        used <- c(used,seltm)
        textxy(xrmsf[seltm],yrig[seltm],labs=seltm, cex=0.6, col="blue")
    }
    for (i in 1:2) {
        seltm <- intersect(sel,eTM[[i]])
        used <- c(used,seltm)
        textxy(xrmsf[seltm],yrig[seltm],labs=seltm, cex=0.6, col="violet")
    }
    for (i in 1:5) {
        seltm <- intersect(sel,eL[[i]])
        used <- c(used,seltm)
        textxy(xrmsf[seltm],yrig[seltm],labs=seltm, cex=0.6, col="seagreen")
    }
    seltm <- setdiff(sel,used)
    textxy(xrmsf[seltm],yrig[seltm],labs=seltm, cex=0.6)
}
if (plt=="coef") {
    if (smooth%%2 == 0) {sel<-c((sel[1]-1),sel)}
    plot(smoothall[sel],smoothcoef[sel],"l",ylim=c(0,max(smoothcoef[all],na.rm=TRUE)),main=paste(window,"-info/RMSF smoothed with ",smooth," ",prot," ",state,sep=""),ylab="Coefficient",xlab="Residue")
    if (zones==1) {
        for (i in 1:10) {polygon(c(TM[[i]][1],TM[[i]],TM[[i]][length(TM[[i]])]),c(0,max(smoothcoef[all],na.rm=TRUE)*as.vector(ones(1,length(TM[[i]]))),0),col="lightblue",border=FALSE)}
        for (i in 1:2) {polygon(c(eTM[[i]][1],eTM[[i]],eTM[[i]][length(eTM[[i]])]),c(0,max(smoothcoef[all],na.rm=TRUE)*as.vector(ones(1,length(eTM[[i]]))),0),col="lightpink",border=FALSE)}
        for (i in 1:5) {polygon(c(eL[[i]][1],eL[[i]],eL[[i]][length(eL[[i]])]),c(0,max(smoothcoef[all],na.rm=TRUE)*as.vector(ones(1,length(eL[[i]]))),0),col="lightgreen",border=FALSE)}
    }
    lines(smoothall[sel],smoothcoef[sel])
    if (sequence==1){
        textxy(smoothall[sel],smoothcoef[sel],labs=reslabels[sel], cex=0.6)        
    }
    for (i in 1:10) {
        textxy(mean(TM[[i]]),0.1,labs=i, cex=0.8)
    }
}
if (plt=="both") {
    plot(sel,yrig[sel],"l",ylim=c(0,max(xrmsf[all],na.rm=TRUE)),main=paste(window,"-info and RMSF ",prot," ",state,sep=""),xlab="Residue")
    if (zones==1) {
        for (i in 1:10) {polygon(c(TM[[i]][1],TM[[i]],TM[[i]][length(TM[[i]])]),c(0,max(xrmsf[all],na.rm=TRUE)*as.vector(ones(1,length(TM[[i]]))),0),col="lightblue",border=FALSE)}
        for (i in 1:2) {polygon(c(eTM[[i]][1],eTM[[i]],eTM[[i]][length(eTM[[i]])]),c(0,max(xrmsf[all],na.rm=TRUE)*as.vector(ones(1,length(eTM[[i]]))),0),col="lightpink",border=FALSE)}
        for (i in 1:5) {polygon(c(eL[[i]][1],eL[[i]],eL[[i]][length(eL[[i]])]),c(0,max(xrmsf[all],na.rm=TRUE)*as.vector(ones(1,length(eL[[i]]))),0),col="lightgreen",border=FALSE)}
    }
    lines(sel,yrig[sel])
    lines(sel,xrmsf[sel],col="red")
    for (i in 1:10) {
        textxy(mean(TM[[i]]-10),0.2,labs=i, cex=0.8)
    }
}
