pair_leut <- function(state) {
    prot <- "LeuT"
    ncovmar <- 10
    require(fields)
    require(gplots)
    #    setwd(paste(prot,state,sep="/"))
    org<-read.table(paste(prot,"/",state,"/",ncovmar,"_1_pairR_ALL.dat",sep=""))
    
    TM <- c("TM1a","TM2a","TM3a","TM4","TM5s","TM6a","TM7a","TM8a","TM9","TM10s","TM11a","TM12s","TM1b","TM2b","TM3b","TM5g","TM6b","TM7b","TM8b","TM10g","TM11b","TM12o")
    TMx <- c("1a","2a","3a","4","5s","6a","7a","8a","9","10s","11a","12s","1b","2b","3b","5g","6b","7b","8b","10g","11b","12o")
    take <- c(1,13,6,17,2,14,7,18,3,15,4,8,19,9,5,10,16,20)#,11,21,12,22)
    div <- dim(org)[1]
    
all <- as.matrix(org[1:div,1:div])
zmntest <- min(all)
zmxtest <- max(all[all<1])
print(zmntest)
print(zmxtest)
#zmn <- 0.309862
#zmx <- 0.78671591
#zmn <- 0.3026252
#zmx <- 0.7947248
zmn=0
zmx=1

a <- as.matrix(org[take,take])
a[a==1]=NA
    
    
    colnames(a) <- TM[take]
    rownames(a) <- TM[take]
    
par(mar=c(4,4,4,5.5))
image(a,axes=FALSE,col=tim.colors(64),main=paste(prot,state,"pairwise interactions",sep=" "),zlim=c(zmn,zmx))
mtext(text=TM[take], side=2, line=0.3, at=seq(0.005,1+0.01,1/(length(take)-1)), las=1, cex=0.9)
mtext(text=TMx[take], side=1, line=0.3, at=seq(0,1+0.01,1/(length(take)-1)), las=1, cex=0.9)
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(zmn,zmx))
    abline(h=-0.02)
    abline(h=0.36)
    abline(h=0.64)
    abline(h=0.74)
    abline(h=0.835)
    abline(h=1.025)
    abline(v=-0.025)
    abline(v=0.355)
    abline(v=0.64)
    abline(v=0.735)
    abline(v=0.83)
    abline(v=1.025)
    
png(paste(ncovmar,"_pair_",prot,"_",state,".png",sep=""),width=800,height=700,res=110)
par(mar=c(5,4,4,6))
image(a,axes=FALSE,col=tim.colors(64),main=paste(prot,state,"pairwise interactions",sep=" "),zlim=c(zmn,zmx))
mtext(text=TM[take], side=2, line=0.3, at=seq(0.005,1+0.01,1/(length(take)-1)), las=1, cex=1)
mtext(text=TMx[take], side=1, line=0.3, at=seq(0,1+0.01,1/(length(take)-1)), las=1, cex=1)
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(zmn,zmx))
abline(h=-0.028)
abline(h=0.44)
abline(h=0.795)
abline(h=0.915)
abline(h=1.03)
    abline(v=-0.028)
    abline(v=0.44)
    abline(v=0.795)
    abline(v=0.915)
    abline(v=1.03)
    dev.off()
#setwd("../..")

}

try(pair_leut("PRi"),TRUE)
try(pair_leut("PRiBB"),TRUE)
try(pair_leut("PRo"),TRUE)
try(pair_leut("PRoBB"),TRUE)
try(pair_leut("PRoc"),TRUE)
try(pair_leut("PRocBB"),TRUE)
