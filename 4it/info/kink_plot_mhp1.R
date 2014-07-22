require(fields)
require(gplots)

prot<-"Mhp1"
state<-"PRiBB"

org<-read.table(paste(prot,state,"10_1_KINK_AVE_R_TCI.dat",sep="/"))

a <- as.matrix(org)


rig <- a[seq(1,length(a),by=2)]

nres <- length(rig)+3
nresan <- nres-3
whole <- c(1:nres)
wholeplot <- whole[1:nresan]+1.5
    
#From 2+smooth/2 to nres-1-smooth/2
#plt<-"rig"
#plt<-"try"
#plt<-"rigvsvar"
plt<-"smooth"
smooth <- 4
minres <- 2+smooth/2
maxres <- nres-1-smooth/2
shift=9
xi=15-shift
xf=maxres
minrig=min(rig)
maxrig=max(rig)

TM1a<-c(30:39)
TM2a<-c(59:68)
TM3a<-c(102:111)
TM4<-c(145:154)
TM5s<-c(176:185)
TM6a<-c(212:221)##########
TM7a<-c(250:259)
TM8a<-c(301:310)
TM9<-c(338:347)###########
TM10s<-c(372:381)#########
TM1b<-c(43:52)
TM2b<-c(72:81)
TM3b<-c(117:126)
TM5g<-c(164:173)
TM6b<-c(227:236)##########
TM7b<-c(264:273)
TM8b<-c(315:324)
TM10g<-c(359:368)#########


TM1a<-c(29:53)
TM2a<-c(59:84)
TM3a<-c(102:133)
TM4<-c(142:157)
TM5s<-c(164:187)
TM6a<-c(207:230)
TM7a<-c(250:274)
TM8a<-c(295:325)
TM9<-c(340:355)
TM10s<-c(357:379)
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
b[intersect(whole,TM10g)]=1
b[intersect(whole,TM10s)]=1
#b[intersect(whole,TM11)]=1
#b[intersect(whole,TM11)]=1
c<-c(1:nresan)
c[]=0
#c[intersect(whole,IL1)]=1
#c[intersect(whole,EL2)]=1
#c[intersect(whole,EL3)]=1
#c[intersect(whole,EL4a)]=1
#c[intersect(whole,EL4b)]=1
#c[intersect(whole,IL5)]=1
    
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

xi=xi-1-smooth/2
xf=xf-1-smooth/2
if (plt=="rig"){
    plot(nx[xi:xf],nrig[xi:xf],"l",ylim=c(minnrig,maxnrig),main=paste("Kinkness smooth ",smooth,sep=""),xlab="Residue", ylab="4-res rigidity")
    lines(whole[(xi+1+smooth/2):(xf+1+smooth/2)],1*maxnrig*b[(xi+1+smooth/2):(xf+1+smooth/2)],ylim=c(minnrig,maxnrig),"l",col="blue")
}
reslist<-nx[xi:xf]
coef<-allcoef[xi:xf]
if (plt=="try"){
    plot(reslist,coef,ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    lines(whole[(xi0):(xf0)],1*maxnrig*b[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="blue")
    lines(whole[(xi0):(xf0)],1*maxnrig*c[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="green")
}

smnx <- c((nx[1]+1.5):(nx[length(nx)]-1.5))
smallcoef<-c(1:length(smnx))
for (i in 1:length(smnx)){
    smallcoef[i] <- sum(allcoef[i:(i+3)])/4
}


smreslist <- smnx[(xi0-5):(xf0-5)]+shift
smcoef <- smallcoef[(xi0-5):(xf0-5)]
if (plt=="smooth"){
    plot(smreslist,smcoef,ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #plot(reslist,coef,ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    lines(whole[(xi0+shift):(xf0+shift)],1*maxnrig*b[(xi0+shift):(xf0+shift)],ylim=c(minnrig,maxnrig),"l",col="blue")
    lines(whole[(xi0+shift):(xf0+shift)],1*maxnrig*c[(xi0+shift):(xf0+shift)],ylim=c(minnrig,maxnrig),"l",col="green")
}

mindevavx<-min(devavx)
maxdevavx<-max(devavx)
b<-b[nx]
if (plt=="rigvsvar"){
    plot(devavx[xi:xf],nrig[xi:xf],col=ifelse(b[xi:xf]==1, "red", "black"),xlim=c(mindevavx,maxdevavx),ylim=c(minnrig,maxnrig),main=paste("Kinkness smooth ",smooth,sep=""),xlab="Residue variance", ylab="4-res rigidity")
    textxy(devavx[xi:xf],nrig[xi:xf], labs=nx[xi:xf], cex=0.5)
}

e2 <- try(write.table(reslist, file=paste("../proteins",prot,state,"reslist.dat",sep="/")),TRUE)
e3 <- try(write.table(coef, file=paste("../proteins",prot,state,"coef.dat",sep="/")),TRUE)












state<-"PRoBB"

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

if (plt=="rig"){
    plot(nx[xi:xf],nrig[xi:xf],"l",ylim=c(minnrig,maxnrig),main=paste("Kinkness smooth ",smooth,sep=""),xlab="Residue", ylab="4-res rigidity")
    lines(whole[(xi+1+smooth/2):(xf+1+smooth/2)],1*maxnrig*b[(xi+1+smooth/2):(xf+1+smooth/2)],ylim=c(minnrig,maxnrig),"l",col="blue")
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
    plot(devavx[xi:xf],nrig[xi:xf],col=ifelse(b[xi:xf]==1, "red", "black"),xlim=c(mindevavx,maxdevavx),ylim=c(minnrig,maxnrig),main=paste("Kinkness smooth ",smooth,sep=""),xlab="Residue variance", ylab="4-res rigidity")
    textxy(devavx[xi:xf],nrig[xi:xf], labs=nx[xi:xf], cex=0.5)
}

smnx <- c((nx[1]+1.5):(nx[length(nx)]-1.5))
smallcoef<-c(1:length(smnx))
for (i in 1:length(smnx)){
    smallcoef[i] <- sum(allcoef[i:(i+3)])/4
}


smreslist <- smnx[(xi0-5):(xf0-5)]+shift
smcoef <- smallcoef[(xi0-5):(xf0-5)]
if (plt=="smooth"){
    lines(smreslist,smcoef,ylim=c(0,1),col="red")
    #plot(reslist,coef,ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #lines(whole[(xi0):(xf0)],1*maxnrig*b[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="blue")
    #lines(whole[(xi0):(xf0)],1*maxnrig*c[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="green")
}


e4 <- try(write.table(reslist, file=paste("../proteins/",prot,state,"reslist.dat",sep="/")),TRUE)
e5 <- try(write.table(coef, file=paste("../proteins/",prot,state,"coef.dat",sep="/")),TRUE)














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

if (plt=="rig"){
    plot(nx[xi:xf],nrig[xi:xf],"l",ylim=c(minnrig,maxnrig),main=paste("Kinkness smooth ",smooth,sep=""),xlab="Residue", ylab="4-res rigidity")
    lines(whole[(xi+1+smooth/2):(xf+1+smooth/2)],1*maxnrig*b[(xi+1+smooth/2):(xf+1+smooth/2)],ylim=c(minnrig,maxnrig),"l",col="blue")
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
    plot(devavx[xi:xf],nrig[xi:xf],col=ifelse(b[xi:xf]==1, "red", "black"),xlim=c(mindevavx,maxdevavx),ylim=c(minnrig,maxnrig),main=paste("Kinkness smooth ",smooth,sep=""),xlab="Residue variance", ylab="4-res rigidity")
    textxy(devavx[xi:xf],nrig[xi:xf], labs=nx[xi:xf], cex=0.5)
}

smnx <- c((nx[1]+1.5):(nx[length(nx)]-1.5))
smallcoef<-c(1:length(smnx))
for (i in 1:length(smnx)){
    smallcoef[i] <- sum(allcoef[i:(i+3)])/4
}


smreslist <- smnx[(xi0-5):(xf0-5)]+shift
smcoef <- smallcoef[(xi0-5):(xf0-5)]
if (plt=="smooth"){
    lines(smreslist,smcoef,ylim=c(0,1),col="blue")
    #plot(reslist,coef,ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #plot(nx[xi:xf],sort(nrig[xi:xf]/devavx[xi:xf]),ylim=c(0,1),"l",main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #hist(sort(nrig[xi:xf]/devavx[xi:xf]),main="4-body info/variance",xlab="Residue", ylab="4-res rigidity")
    #lines(whole[(xi0):(xf0)],1*maxnrig*b[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="blue")
    #lines(whole[(xi0):(xf0)],1*maxnrig*c[(xi0):(xf0)],ylim=c(minnrig,maxnrig),"l",col="green")
}


e6 <- try(write.table(reslist, file=paste("../proteins/",prot,state,"reslist.dat",sep="/")),TRUE)
e7 <- try(write.table(coef, file=paste("../proteins/",prot,state,"coef.dat",sep="/")),TRUE)


