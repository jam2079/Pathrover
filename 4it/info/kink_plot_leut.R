require(fields)
require(gplots)
require(calibrate)

prot<-"LeuT"
state<-"PRoBB"

org<-read.table(paste(prot,state,"10_1_KINK_AVE_R_TCI.dat",sep="/"))

a <- as.matrix(org)


rig <- a[seq(1,length(a),by=2)]

nres <- length(rig)+3
nresan <- nres-3
whole <- c(1:nres)
wholeplot <- whole[1:nresan]+1.5
    
#From 2+smooth/2 to nres-1-smooth/2
plt<-"rig"
#plt<-"var"
#plt<-"rigvsvar"
#plt<-"try"
#plt<-"smooth"
#plt<-"fourier"
smooth <- 4
minres <- 2+smooth/2
maxres <- nres-1-smooth/2
xi=10
xf=500

minrig=min(rig)
maxrig=max(rig)

TM1a<-c(13:22)
TM2a<-c(42:51)
TM3a<-c(90:99)
TM4<-c(169:178)
TM5s<-c(204:213)
TM6a<-c(244:253)
TM7a<-c(276:285)
TM8a<-c(338:347)
TM9<-c(378:387)
#TM10s<-c(414:423)
TM11a<-c(450:459)
TM12s<-c(487:496)
TM1b<-c(26:35)
TM2b<-c(56:65)
TM3b<-c(107:116)
TM5g<-c(193:202)
TM6b<-c(261:270)
TM7b<-c(289:298)
TM8b<-c(354:363)
TM10g<-c(398:407)
TM11b<-c(467:476)
TM12o<-c(501:510)
IL1<-c(75:84)
EL2<-c(140:149)
EL3<-c(223:232)
EL4a<-c(308:317)
EL4b<-c(322:331)
IL5<-c(428:437)


TM1a<-c(11:37)
TM2a<-c(41:70)
TM3a<-c(88:124)
TM4<-c(166:183)
TM5s<-c(191:213)
TM6a<-c(241:266)
TM7a<-c(276:306)
TM8a<-c(337:369)
TM9<-c(375:395)
TM10s<-c(399:424)
TM11a<-c(447:477)
TM12s<-c(483:509)
IL1<-c(77:84)
EL2<-c(137:152)
EL3<-c(223:231)
EL4a<-c(308:331)
IL5<-c(429:437)

b<-c(1:nresan)
b[]=0
b[intersect(whole,TM1a)]=1
b[intersect(whole,TM1b)]=1
b[intersect(whole,TM2a)]=1
b[intersect(whole,TM2b)]=1
b[intersect(whole,TM3a)]=1
b[intersect(whole,TM3b)]=1
b[intersect(whole,TM4)]=1
b[intersect(whole,TM5g)]=1
b[intersect(whole,TM5s)]=1
b[intersect(whole,TM6a)]=1
b[intersect(whole,TM6b)]=1
b[intersect(whole,TM7a)]=1
b[intersect(whole,TM7b)]=1
b[intersect(whole,TM8a)]=1
b[intersect(whole,TM8b)]=1
b[intersect(whole,TM9)]=1
b[intersect(whole,TM9)]=1
b[intersect(whole,TM10g)]=1
b[intersect(whole,TM10s)]=1
#b[intersect(whole,TM11a)]=1
#b[intersect(whole,TM11b)]=1
#b[intersect(whole,TM12s)]=1
#b[intersect(whole,TM12o)]=1
c<-c(1:nresan)
c[]=0
c[intersect(whole,IL1)]=1
c[intersect(whole,EL2)]=1
c[intersect(whole,EL3)]=1
c[intersect(whole,EL4a)]=1
c[intersect(whole,EL4b)]=1
c[intersect(whole,IL5)]=1
    
ny <- c((2+smooth/2):(nres-1-smooth/2))-smooth/2-1
nrig <- ny
for (i in ny) {
    nrig[i]<-sum(rig[(i):(i+smooth-1)])/smooth    
}
nx <- c((2+smooth/2):(nres-1-smooth/2))

dev<-as.matrix(read.table(paste(prot,state,"10_1_KINK_AVE_DEV_TCI.dat",sep="/")))
devav<-c()
for (i in 1:nres){
    devav[i] <- sqrt(sum(dev[(4*(i-1)+1):(4*i)]^2))
}
devavx<-devav[nx]

allcoef<-nrig/devavx

minnrig=min(nrig)
maxnrig=max(nrig)

xi0<-xi
xf0<-xf

xi=xi0-1-smooth/2
xf=xf0-1-smooth/2
reslist<-nx[xi:xf]
coef<-allcoef[xi:xf]
rescodes<-c("M","E","V","K","R","E","H","W","A","T","R","L","G","L","I","L","A","M","A","G","N","A","V","G","L","G","N","F","L","R","F","P","V","Q","A","A","E","N","G","G","G","A","F","M","I","P","Y","I","I","A","F","L","L","V","G","I","P","L","M","W","I","E","W","A","M","G","R","Y","G","G","A","Q","G","H","G","T","T","P","A","I","F","Y","L","L","W","R","N","R","F","A","K","I","L","G","V","F","G","L","W","I","P","L","V","V","A","I","Y","Y","V","Y","I","E","S","W","T","L","G","F","A","I","K","F","L","V","G","L","V","P","E","P","P","P","N","A","T","D","P","D","S","I","L","R","P","F","K","E","F","L","Y","S","Y","I","G","V","P","K","G","D","E","P","I","L","K","P","S","L","F","A","Y","I","V","F","L","I","T","M","F","I","N","V","S","I","L","I","R","G","I","S","K","G","I","E","R","F","A","K","I","A","M","P","T","L","F","I","L","A","V","F","L","V","I","R","V","F","L","L","E","T","P","N","G","T","A","A","D","G","L","N","F","L","W","T","P","D","F","E","K","L","K","D","P","G","V","W","I","A","A","V","G","Q","I","F","F","T","L","S","L","G","F","G","A","I","I","T","Y","A","S","Y","V","R","K","D","Q","D","I","V","L","S","G","L","T","A","A","T","L","N","E","K","A","E","V","I","L","G","G","S","I","S","I","P","A","A","V","A","F","F","G","V","A","N","A","V","A","I","A","K","A","G","A","F","N","L","G","F","I","T","L","P","A","I","F","S","Q","T","A","G","G","T","F","L","G","F","L","W","F","F","L","L","F","F","A","G","L","T","S","S","I","A","I","M","Q","P","M","I","A","F","L","E","D","E","L","K","L","S","R","K","H","A","V","L","W","T","A","A","I","V","F","F","S","A","H","L","V","M","F","L","N","K","S","L","D","E","M","D","F","W","A","G","T","I","G","V","V","F","F","G","L","T","E","L","I","I","F","F","W","I","F","G","A","D","K","A","W","E","E","I","N","R","G","G","I","I","K","V","P","R","I","Y","Y","Y","V","M","R","Y","I","T","P","A","F","L","A","V","L","L","V","V","W","A","R","E","Y","I","P","K","I","M","E","E","T","H","W","T","V","W","I","T","R","F","Y","I","I","G","L","F","L","F","L","T","F","L","V","F","L","A","E","R","R","R","N","H","E","S","A","G","T","L","V","P","R")
rescodes<-rescodes[1:513]
reslabels<-paste(rescodes,c(1:513),sep="")
if (plt=="rig"){
#    png("info.png",width=800,height=700,res=110)
    par(mar=c(4,4,4,4))
    #    plot(nx[xi:xf],nrig[xi:xf],"l",ylim=c(minnrig,maxnrig),main=paste("4-body info",prot,state),xlab="Residue", ylab="4-res rigidity")
    plot(reslist,nrig[xi:xf],ylim=c(0,1),"l",main=paste("4-body info",prot,state),xlab="Residue", ylab="4-res info")
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #lines(whole[(xi0):(xf0)],1*maxnrig*b[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="blue")
    #lines(whole[(xi0):(xf0)],1*maxnrig*c[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="green")
    #    lines(whole[(xi+1+smooth/2):(xf+1+smooth/2)],1*maxnrig*b[(xi+1+smooth/2):(xf+1+smooth/2)],ylim=c(minnrig,maxnrig),"l",col="blue")
#    dev.off()
    
}
if (plt=="var"){
    png("rmsf.png",width=800,height=700,res=110)
    par(mar=c(4,4,4,4))
    #    plot(nx[xi:xf],nrig[xi:xf],"l",ylim=c(minnrig,maxnrig),main=paste("4-body info",prot,state),xlab="Residue", ylab="4-res rigidity")
    plot(reslist,devavx[xi:xf],"l",main=paste("RMSF",prot,state),xlab="Residue", ylab="RMSF",cex=2.5)
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    lines(whole[(xi0):(xf0)],7*maxnrig*b[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="blue")
    lines(whole[(xi0):(xf0)],7*maxnrig*c[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="green")
    #    lines(whole[(xi+1+smooth/2):(xf+1+smooth/2)],1*maxnrig*b[(xi+1+smooth/2):(xf+1+smooth/2)],ylim=c(minnrig,maxnrig),"l",col="blue")
    dev.off()
}
if (plt=="try"){
#    png("coef.png",width=800,height=700,res=110)
    par(mar=c(4,4,4,4))
    plot(reslist,coef,ylim=c(0,1),"l",main=paste("4-body info/RMSF TM7",prot,state),xlab="Residue", ylab="Coefficient")
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    lines(whole[(xi0):(xf0)],1*maxnrig*b[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="blue")
    #lines(whole[(xi0):(xf0)],1*maxnrig*c[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="green")
#    lines(smreslist,smcoef)
    #textxy(reslist,coef, labs=reslabels[(xi0):(xf0)], cex=0.6)
#    dev.off()
}
if (plt=="fourier"){
    require(TSA)
    four<-periodogram(coef,log='no',plot=TRUE,ylab="Periodogram", xlab="Frequency",lwd=2)
    freqs <- four[[1]]*length(coef)
    foury <- four[[2]]
    #plot(freqs,foury,"l")
}

smnx <- c((nx[1]+1.5):(nx[length(nx)]-1.5))
smallcoef<-c(1:length(smnx))
for (i in 1:length(smnx)){
    smallcoef[i] <- sum(allcoef[i:(i+3)])/4
}


try(smreslist <- smnx[(xi0-5):(xf0-5)],TRUE)
try(smcoef <- smallcoef[(xi0-5):(xf0-5)],TRUE)
if (plt=="smooth"){
#    png("smooth.png",width=800,height=700,res=110)
    par(mar=c(4,4,4,4))
    plot(smreslist,smcoef,ylim=c(0,1),"l",main=paste("4-body info/RMSF",prot,state,"and PRocBB TM8","smooth"),xlab="Residue", ylab="4-res info")
    #plot(reslist,coef,ylim=c(0,1),"l",main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    lines(whole[(xi0):(xf0)],1*maxnrig*b[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="blue")
    lines(whole[(xi0):(xf0)],1*maxnrig*c[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="green")
#    dev.off()
}

mindevavx<-min(devavx)
maxdevavx<-max(devavx)
b<-b[nx]
roloc<-b+c[nx]
if (plt=="rigvsvar"){
    png("rigsvar.png",width=800,height=700,res=110)
    par(mar=c(4,4,4,4))
    plot(devavx[xi:xf],nrig[xi:xf],col=ifelse(roloc[xi:xf]==1, "blue", "black"),xlim=c(mindevavx,maxdevavx),ylim=c(minnrig,maxnrig),main=paste("4-body info vs RMSF",prot,state),xlab="Residue RMSF", ylab="4-res info")
    outliers<-c(10:500)
    outliers<-c(67,255,314,354)
    textxy(devavx[outliers],nrig[outliers], labs=reslabels[nx[outliers]], cex=0.8)
    dev.off()
}

e2 <- try(write.table(reslist, file=paste("../proteins",prot,state,"reslist.dat",sep="/")),TRUE)
e3 <- try(write.table(coef, file=paste("../proteins",prot,state,"coef.dat",sep="/")),TRUE)









flag=1

if (flag==1){
state<-"PRocBB"

org<-read.table(paste(prot,state,"10_1_KINK_AVE_R_TCI.dat",sep="/"))

a <- as.matrix(org)


rig <- a[seq(1,length(a),by=2)]

#From 2+smooth/2 to nres-1-smooth/2
#plt<-"rig"
#plt<-"try"
#plt<-"rigvsvar"

ny <- c((2+smooth/2):(nres-1-smooth/2))-smooth/2-1
nrig <- ny
for (i in ny) {
    nrig[i]<-sum(rig[(i):(i+smooth-1)])/smooth    
}
nx <- c((2+smooth/2):(nres-1-smooth/2))

dev<-as.matrix(read.table(paste(prot,state,"10_1_KINK_AVE_DEV_TCI.dat",sep="/")))
devav<-c()
for (i in 1:nres){
    devav[i] <- sqrt(sum(dev[(4*(i-1)+1):(4*i)]^2))
}
devavx<-devav[nx]
allcoef<-nrig/devavx

minnrig=min(nrig)
maxnrig=max(nrig)

xi=xi0-1-smooth/2
xf=xf0-1-smooth/2
if (plt=="rig"){
    lines(nx[xi:xf],nrig[xi:xf],col="red")
    #lines(whole[(xi+1+smooth/2):(xf+1+smooth/2)],1*maxnrig*b[(xi+1+smooth/2):(xf+1+smooth/2)],ylim=c(minnrig,maxnrig),"l",col="blue")
}

reslist<-nx[xi:xf]
coef<-allcoef[xi:xf]
if (plt=="try"){
    lines(reslist,coef,ylim=c(0,1),"l",col="red")
}

mindevavx<-min(devavx)
maxdevavx<-max(devavx)
#b<-b[nx]
if (plt=="rigvsvar"){
    plot(devavx[xi:xf],nrig[xi:xf],col=ifelse(b[xi:xf]==1, "blue", "black"),xlim=c(mindevavx,maxdevavx),ylim=c(minnrig,maxnrig),main=paste("Kinkness smooth ",smooth,sep=""),xlab="Residue RMSF", ylab="4-res rigidity")
    textxy(devavx[xi:xf],nrig[xi:xf], labs=nx[xi:xf], cex=0.5)
}

smnx <- c((nx[1]+1.5):(nx[length(nx)]-1.5))
smallcoef<-c(1:length(smnx))
for (i in 1:length(smnx)){
    smallcoef[i] <- sum(allcoef[i:(i+3)])/4
}


smreslist <- smnx[(xi0-5):(xf0-5)]
smcoef <- smallcoef[(xi0-5):(xf0-5)]
if (plt=="smooth"){
    lines(smreslist,smcoef,ylim=c(0,1),col="red")
    #plot(reslist,coef,ylim=c(0,1),"l",main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/RMSF",xlab="Residue", ylab="4-res rigidity")
    #lines(whole[(xi0):(xf0)],1*maxnrig*b[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="blue")
    #lines(whole[(xi0):(xf0)],1*maxnrig*c[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="green")
}


e4 <- try(write.table(reslist, file=paste("../proteins/",prot,state,"reslist.dat",sep="/")),TRUE)
e5 <- try(write.table(coef, file=paste("../proteins/",prot,state,"coef.dat",sep="/")),TRUE)

#dev.off()

}