rm(list=ls())
prot <- "LeuT"
state <- "PRoBB"
ncov <- 1
ii <- 1
jj <- 8
eig <- 1

args<-c(ncov,1,"fixed.dcd",prot,state)
atom <- read.table(paste("mca/",prot,"/",state,"/","atom.vector",sep=""))[,1]
file_name <- paste("mca/",prot,"/",state,"/",args[1],"_",args[2],"_", args[3], ".Rdata", sep="")
if (file.exists(file_name)) {
    load(file_name)
} else {
    for (i in 1:args[1]) {
        name <- paste(i, "_", args[2], "_", args[3], ".varcov.dat", sep="")
        if (i ==1) {
            C <- try(list(as.matrix(read.table(name))))
        } else {
            C[[i]] <- try(as.matrix(read.table(name)))
        }
        if (class(C[[i]]) == "try-error") {
            print(paste("Error in matrix ", i, ".", sep=""))
        }
    }
}

require(caTools)
source("itfunctions.R")
require(zoo)
require(fields)

if (prot == "LeuT") {
    nres <- 513
    shift <- 0
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
    TM1a<-c(11:22)
    TM1b<-c(25:37)
    TM6a<-c(241:255)
    TM6b<-c(261:266)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12,TM1a,TM1b,TM6a,TM6b)
    TMlab <- list("TM1","TM2","TM3","TM4","TM5","TM6","TM7","TM8","TM9","TM10","TM11","TM12","TM1a","TM1b","TM6a","TM6b")
}
if (prot == "Mhp1") {
    nres <- 461
    shift<-9
    TM1<-c(29:53)-shift
    TM2<-c(59:84)-shift
    TM3<-c(102:133)-shift
    TM4<-c(142:157)-shift
    TM5<-c(164:187)-shift
    TM6<-c(207:230)-shift
    TM7<-c(250:274)-shift
    TM8<-c(295:325)-shift
    TM9<-c(340:355)-shift
    TM10<-c(357:379)-shift
    TM1a<-c(29:40)-shift
    TM1b<-c(43:53)-shift
    TM6a<-c(207:221)-shift
    TM6b<-c(227:230)-shift
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM1a,TM1b,TM6a,TM6b)
    TMlab <- list("TM1","TM2","TM3","TM4","TM5","TM6","TM7","TM8","TM9","TM10","TM1a","TM1b","TM6a","TM6b")
}
d <- read.table(paste("mca/",prot,"/",state,"/d_",ncov,"_1_MCA_",TMlab[[ii]],"_",TMlab[[jj]],".dat",sep=""))
d <- d[[1]]
u <- read.table(paste("mca/",prot,"/",state,"/u_",ncov,"_1_MCA_",TMlab[[ii]],"_",TMlab[[jj]],".dat",sep=""))
u <- as.vector(u[[eig]])
v <- read.table(paste("mca/",prot,"/",state,"/v_",ncov,"_1_MCA_",TMlab[[ii]],"_",TMlab[[jj]],".dat",sep=""))
v <- v[[eig]]

nii <- length(TM[[ii]])
varu <- NULL
minii <- min(TM[[ii]])
set <- 12
for (i in 1:nii) {
    part <- c(((i-1)*set+1):(set*i))
    varu[i] <- t(u[part])%*%cov2cor(C[[1]][part+12*(minii-1),part+12*(minii-1)])%*%u[part]
}
njj <- length(TM[[jj]])
varv <- c(1:njj)
minjj <- min(TM[[jj]])
for (i in 1:njj) {
    part <- c(((i-1)*set+1):(set*i))
    varv[i] <- t(v[part])%*%cov2cor(C[[1]][part+12*(minjj-1),part+12*(minjj-1)])%*%v[part]
}

plot(1:nii,varu,"l",xlim=c(0,max(nii,njj)),ylim=c(0,1),main=paste("Black",ii,", blue",jj))
lines(1:njj,varv,"l",col="blue",ylim=c(0,1))

Ddd <- cov2cor(C[[1]])

a <- varu%*%t(varv)
par(mar=c(3,3,3,5.5))
image(abs(Ddd[(12*(minii-1)):(12*(minii-1+nii)),(12*(minjj-1)):(12*(minjj-1+njj))]),axes=FALSE,col=tim.colors(64))
image.plot(abs(Ddd[(12*(minii-1)):(12*(minii-1+nii)),(12*(minjj-1)):(12*(minjj-1+njj))]),col=tim.colors(64),legend.only=TRUE)
#par(mar=c(3,3,3,5.5))
#image(a,axes=FALSE,col=tim.colors(64))
#image.plot(a,col=tim.colors(64),legend.only=TRUE)

print(rev(d))
