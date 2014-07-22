rm(list=ls())
save <- 0
#args <- commandArgs(TRUE)
#ncovmat <- args[1]
#prot <- args[2]
boot <- 1

ncovmat <- 5
prot <- "LEUBB"
sz <- 5
view <- c(1,515)

corr <- sz/2-0.5
datfile <- paste("data/sweeprigidity_",prot,"_",ncovmat,"_covmat_window_",sz,".dat",sep="")
pngfile <- paste("plots/sweeprigidity_",prot,"_",ncovmat,"_covmat_window_",sz,".png",sep="")

a<-read.table(datfile)
div <- dim(a)[2]/2
a <- a[seq(1,2*div,by=2)]
x <- 1:div+corr
y <- as.vector(as.matrix(a))

if ((prot == "LEU") || (prot == "LEUBB") || (prot == "LEUSC")) {
    TM1a<-c(11:22)
    TM1b<-c(25:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6a<-c(241:255)
    TM6b<-c(261:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:394)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:512)
}
if ((prot == "LEU_VAL") || (prot == "LEU_VALBB") || (prot == "LEU_VALSC")) {
    TM1a<-c(11:22)
    TM1b<-c(29:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:184)
    TM5<-c(191:215)
    TM6a<-c(241:255)
    TM6b<-c(261:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:394)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:511)
}
if ((prot == "ALA") || (prot == "ALABB") || (prot == "ALASC")) {
    TM1a<-c(11:22)
    TM1b<-c(29:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6a<-c(241:255)
    TM6b<-c(261:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:395)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:511)
}
TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)



if (save==1) {png(pngfile,width=1100,height=825,res=160)}
title <- paste(prot,"rigidity with",ncovmat,"matrices and window size",sz)
x <- (view[1]+corr):(view[2]-corr)
yv <- y[view[1]:(view[2]-2*corr)]
plot(x,yv,"l",xlab="Residue",ylab="Rigidity",ylim=c(0,1),main=title)
for (i in 1:length(TM)) {
    res <- unlist(TM[[i]])
    frst <- res[1]
    lst <- max(res)
    cx <- c((frst+corr),(frst+corr):(lst-corr),(lst-corr))
    cy <- c(0,y[frst:(lst-2*corr)],0)
    polygon(cx,cy,col="skyblue")
}
if (save==1) {dev.off()}
