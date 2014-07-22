rm(list=ls())
prot <- "LeuT"
if(prot=="LeuT"){
    nres <- 513
    TM1a<-c(11:22)
    TM1b<-c(25:37)
    TM2<-c(41:70)
    TM3<-c(88:124)
    TM4<-c(166:183)
    TM5<-c(191:213)
    TM6a<-c(241:255)
    TM6b<-c(261:266)
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
    TM <- list(TM1a,TM1b,TM2,TM3,TM4,TM5,TM6a,TM6b,TM7,TM8,TM9,TM10)
    lTM <- list("1a","1b","2","3","4","5","6a","6b","7","8","9","10")
    eTM <- list(TM11,TM12)
    eL <- list(IL1,EL2,EL3,EL4,IL5)
    TM1 <- c(11:37)
    TM6 <- c(241:266)
}
if(prot=="Mhp1"){nres <- 461}
state <- "PRoBB"
plt <- "info"
#plt <- "rmsf"
#plt <- "coef"
plt <- "dev"
ncov <- 10
windoworg <- 4
windownew <- 7
smooth <- 4
zones <- 1
sequence <- 0
other <- 0
detect <- 0.52
minres <- windoworg
maxres <- nres-windoworg+1
all <- c(minres:maxres)
sel <- c(TM4)
#sel <- c(all)


require(fields)
require(gplots)
require(calibrate)
require(zoo)
natemp <- c(1:nres)
natemp[] <- NA

rig <- as.matrix(read.table(paste(prot,"/",state,"/",ncov,"_1_KINK_AVE_R_TCI",windoworg,".dat",sep="")))
rig <- rig[seq(1,length(rig),by=2)]
rmsf <- as.matrix(read.table(paste(prot,"/",state,"/",ncov,"_1_KINK_AVE_DEV_TCI.dat",sep="")))
rescodes<-c("M","E","V","K","R","E","H","W","A","T","R","L","G","L","I","L","A","M","A","G","N","A","V","G","L","G","N","F","L","R","F","P","V","Q","A","A","E","N","G","G","G","A","F","M","I","P","Y","I","I","A","F","L","L","V","G","I","P","L","M","W","I","E","W","A","M","G","R","Y","G","G","A","Q","G","H","G","T","T","P","A","I","F","Y","L","L","W","R","N","R","F","A","K","I","L","G","V","F","G","L","W","I","P","L","V","V","A","I","Y","Y","V","Y","I","E","S","W","T","L","G","F","A","I","K","F","L","V","G","L","V","P","E","P","P","P","N","A","T","D","P","D","S","I","L","R","P","F","K","E","F","L","Y","S","Y","I","G","V","P","K","G","D","E","P","I","L","K","P","S","L","F","A","Y","I","V","F","L","I","T","M","F","I","N","V","S","I","L","I","R","G","I","S","K","G","I","E","R","F","A","K","I","A","M","P","T","L","F","I","L","A","V","F","L","V","I","R","V","F","L","L","E","T","P","N","G","T","A","A","D","G","L","N","F","L","W","T","P","D","F","E","K","L","K","D","P","G","V","W","I","A","A","V","G","Q","I","F","F","T","L","S","L","G","F","G","A","I","I","T","Y","A","S","Y","V","R","K","D","Q","D","I","V","L","S","G","L","T","A","A","T","L","N","E","K","A","E","V","I","L","G","G","S","I","S","I","P","A","A","V","A","F","F","G","V","A","N","A","V","A","I","A","K","A","G","A","F","N","L","G","F","I","T","L","P","A","I","F","S","Q","T","A","G","G","T","F","L","G","F","L","W","F","F","L","L","F","F","A","G","L","T","S","S","I","A","I","M","Q","P","M","I","A","F","L","E","D","E","L","K","L","S","R","K","H","A","V","L","W","T","A","A","I","V","F","F","S","A","H","L","V","M","F","L","N","K","S","L","D","E","M","D","F","W","A","G","T","I","G","V","V","F","F","G","L","T","E","L","I","I","F","F","W","I","F","G","A","D","K","A","W","E","E","I","N","R","G","G","I","I","K","V","P","R","I","Y","Y","Y","V","M","R","Y","I","T","P","A","F","L","A","V","L","L","V","V","W","A","R","E","Y","I","P","K","I","M","E","E","T","H","W","T","V","W","I","T","R","F","Y","I","I","G","L","F","L","F","L","T","F","L","V","F","L","A","E","R","R","R","N","H","E","S","A","G","T","L","V","P","R")
rescodes<-rescodes[1:nres]
reslabels<-paste(rescodes,c(1:nres),sep="")

yrig <- rollmean(rig,windoworg,align="left",fill=NA)
nafill <- natemp[1:(windoworg-1)]
yrig <- c(nafill,yrig)

xrmsf <- natemp
for (i in 1:nres) {
    xrmsf[i] <- sqrt(sum(rmsf[(4*(i-1)+1):(4*i)]^2))
}

coef <- yrig/xrmsf

high <- ceiling(windownew/2)
low <- floor(windownew/2)
devres <- natemp
for (i in high:(nres-low)){
    seg <- c(yrig[(i-low):(i+low)])
#    seg <- c(yrig[(i-low):(i-1)],yrig[(i+1):(i+low)])
    mn <- mean(seg)
    dv <- sd(seg)
#    devres[i] <- (yrig[i]-mn)/dv
    devres[i] <- yrig[i]-mn
}

smoothall <- natemp
smoothall[all] <- rollmean(all,smooth,fill=NA)
smoothyrig <- natemp
smoothyrig[all] <- rollmean(yrig[all],smooth,fill=NA)
smoothxrmsf <- natemp
smoothxrmsf[all] <- rollmean(xrmsf[all],smooth,fill=NA)
smoothcoef <- natemp
smoothcoef[all] <- rollmean(coef[all],smooth,fill=NA)
smoothdevres <- natemp
smoothdevres[!is.na(devres)] <- rollmean(devres[!is.na(devres)],smooth,fill=NA)

if (plt=="info") {
    y <- smoothyrig
    title <- paste(windoworg,"-info smooth ",smooth," ",prot," ",state,sep="")
    if (other==1) {title <- paste(windoworg,"-info smooth ",smooth," ",prot," ",state," ","PRocBB",sep="")}
}
if (plt=="rmsf") {
    y <- smoothxrmsf
    title <- paste("RMSF smooth ",smooth," ",prot," ",state,sep="")
    if (other==1) {title <- paste("RMSF smooth ",smooth," ",prot," ",state," ","PRocBB",sep="")}
}
if (plt=="coef") {
    y <- smoothcoef
    title <- paste(windoworg,"-info/RMSF smooth",smooth," ",prot," ",state,sep="")
    if (other==1) {title <- paste(windoworg,"-info/RMSF smooth ",smooth," ",prot," ",state," ","PRocBB",sep="")}
}
if (plt=="dev") {
    y <- smoothdevres
    title <- paste(windoworg,"-info std dev window ",windownew,prot," ",state,sep="")
    if (other==1) {    title <- paste(windoworg,"-info smooth ",smooth," ",prot," ",state," ","PRocBB",sep="")}
}
plot(sel,y[sel],"l",ylim=c(min(y[all],na.rm=TRUE),max(y,na.rm=TRUE)),main=title,xlab="Residue")
if (zones==1) {
    for (i in 1:12) {polygon(c(TM[[i]][1],TM[[i]],TM[[i]][length(TM[[i]])]),c(min(y[all],na.rm=TRUE),max(y[all],na.rm=TRUE)*as.vector(ones(1,length(TM[[i]]))),min(y[all],na.rm=TRUE)),col="lightblue",border=FALSE)}
    for (i in 1:2) {polygon(c(eTM[[i]][1],eTM[[i]],eTM[[i]][length(eTM[[i]])]),c(min(y[all],na.rm=TRUE),max(y[all],na.rm=TRUE)*as.vector(ones(1,length(eTM[[i]]))),min(y[all],na.rm=TRUE)),col="lightpink",border=FALSE)}
    for (i in 1:5) {polygon(c(eL[[i]][1],eL[[i]],eL[[i]][length(eL[[i]])]),c(min(y[all],na.rm=TRUE),max(y[all],na.rm=TRUE)*as.vector(ones(1,length(eL[[i]]))),min(y[all],na.rm=TRUE)),col="lightgreen",border=FALSE)}
}
lines(sel,y[sel])
for (i in 1:12) {
    textxy(mean(TM[[i]]-1),min(y[sel],na.rm=TRUE),labs=lTM[i], cex=0.8)
}
if (sequence==1){
    textxy(sel,y[sel],labs=reslabels[sel], cex=0.6)        
}
lines(sel,-detect*as.vector(ones(1,length(sel))),col="red")






if (other==1){
    if(state=="PRoBB"){state <- "PRocBB"}
    else if(state=="PRocBB"){state <- "PRoBB"}
 
    rig <- as.matrix(read.table(paste(prot,"/",state,"/",ncov,"_1_KINK_AVE_R_TCI",windoworg,".dat",sep="")))
    rig <- rig[seq(1,length(rig),by=2)]
    
    yrig <- rollmean(rig,windoworg,align="left",fill=NA)
    nafill <- natemp[1:(windoworg-1)]
    yrig <- c(nafill,yrig)
    
    smoothall <- natemp
    smoothall[all] <- rollmean(all,smooth,fill=NA)
    smoothyrig <- natemp
    smoothyrig[all] <- rollmean(yrig[all],smooth,fill=NA)
    
    high <- ceiling(windownew/2)
    low <- floor(windownew/2)
    devres <- natemp
    for (i in high:(nres-low)){
        seg <- yrig[(i-low):(i+low)]
        mn <- mean(seg)
        dv <- sd(seg)
        devres[i] <- (yrig[i]-mn)/dv
    }
    smoothdevres <- natemp
    smoothdevres[!is.na(devres)] <- rollmean(devres[!is.na(devres)],smooth,fill=NA)
    
    if (plt=="info") {y <- smoothyrig}
    if (plt=="dev") {y <- smoothdevres}
    
    lines(sel,y[sel],col="red")
    if (sequence==1){
        textxy(sel,y[sel],labs=reslabels[sel], cex=0.6,col="red")
    }
    
}