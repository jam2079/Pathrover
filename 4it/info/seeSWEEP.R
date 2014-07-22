rm(list=ls())
prot <- "Mhp1"
state <- "PRiBB"
window <- 4
for (prot in c("LeuT","Mhp1")) {
for (state in c("PRi","PRiBB","PRo","PRoBB","PRoc","PRocBB")) {
for (window in 1:10) {
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
    lab <- c("1","2","3","4","5","6","7","8","9","10")
    pos <- c(0.05,0.15,0.28,0.38,0.45,0.55,0.65,0.77,0.87,0.96)
    eTM <- list(TM11,TM12)
    eL <- list(IL1,EL2,EL3,EL4,IL5)
    rescodes<-c("M","E","V","K","R","E","H","W","A","T","R","L","G","L","I","L","A","M","A","G","N","A","V","G","L","G","N","F","L","R","F","P","V","Q","A","A","E","N","G","G","G","A","F","M","I","P","Y","I","I","A","F","L","L","V","G","I","P","L","M","W","I","E","W","A","M","G","R","Y","G","G","A","Q","G","H","G","T","T","P","A","I","F","Y","L","L","W","R","N","R","F","A","K","I","L","G","V","F","G","L","W","I","P","L","V","V","A","I","Y","Y","V","Y","I","E","S","W","T","L","G","F","A","I","K","F","L","V","G","L","V","P","E","P","P","P","N","A","T","D","P","D","S","I","L","R","P","F","K","E","F","L","Y","S","Y","I","G","V","P","K","G","D","E","P","I","L","K","P","S","L","F","A","Y","I","V","F","L","I","T","M","F","I","N","V","S","I","L","I","R","G","I","S","K","G","I","E","R","F","A","K","I","A","M","P","T","L","F","I","L","A","V","F","L","V","I","R","V","F","L","L","E","T","P","N","G","T","A","A","D","G","L","N","F","L","W","T","P","D","F","E","K","L","K","D","P","G","V","W","I","A","A","V","G","Q","I","F","F","T","L","S","L","G","F","G","A","I","I","T","Y","A","S","Y","V","R","K","D","Q","D","I","V","L","S","G","L","T","A","A","T","L","N","E","K","A","E","V","I","L","G","G","S","I","S","I","P","A","A","V","A","F","F","G","V","A","N","A","V","A","I","A","K","A","G","A","F","N","L","G","F","I","T","L","P","A","I","F","S","Q","T","A","G","G","T","F","L","G","F","L","W","F","F","L","L","F","F","A","G","L","T","S","S","I","A","I","M","Q","P","M","I","A","F","L","E","D","E","L","K","L","S","R","K","H","A","V","L","W","T","A","A","I","V","F","F","S","A","H","L","V","M","F","L","N","K","S","L","D","E","M","D","F","W","A","G","T","I","G","V","V","F","F","G","L","T","E","L","I","I","F","F","W","I","F","G","A","D","K","A","W","E","E","I","N","R","G","G","I","I","K","V","P","R","I","Y","Y","Y","V","M","R","Y","I","T","P","A","F","L","A","V","L","L","V","V","W","A","R","E","Y","I","P","K","I","M","E","E","T","H","W","T","V","W","I","T","R","F","Y","I","I","G","L","F","L","F","L","T","F","L","V","F","L","A","E","R","R","R","N","H","E","S","A","G","T","L","V","P","R")
}
if(prot=="Mhp1"){
    nres <- 461
    TM1<-c(29:53)
    TM2<-c(59:84)
    TM3<-c(102:133)
    TM4<-c(142:157)
    TM5<-c(164:187)
    TM6<-c(207:230)
    TM7<-c(250:274)
    TM8<-c(295:325)
    TM9<-c(340:355)
    TM10<-c(357:379)
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10)
    lab <- c("1","2","3","4","5","6","7","8","9","10")    
    pos <- c(0.05,0.15,0.27,0.38,0.46,0.56,0.66,0.78,0.88,0.95)
}
for (i in 1:10){
    TM[[i]] <- TM[[i]][1:(length(TM[[i]])-window +1)]
}
plt <- "sweep"
ncov <- 3
print(prot)
print(state)
print(window)
lines <- 1
minres <- window
maxres <- nres-window+1
all <- c(1:maxres)
sel <- c(TM9,TM10)
sel <- c(unlist(TM))
#sel <- c(TM1,TM2,TM6,TM7,TM3,TM4,TM8,TM9,TM5,TM10)

require(fields)
require(gplots)
require(calibrate)
require(zoo)

sel0 <- sel
if (file.exists(paste("sweep/sweep",prot,state,ncov,"covmat_window",window,".png",sep="_"))) next
a <- try(read.table(paste(prot,"/",state,"/",ncov,"_",1,"_sweep_",window,"_.dat",sep="")),TRUE)
if ('try-error' %in% class(a)) next

#a <- as.matrix(a[sel,sel])
a <- as.matrix(a[(1:nres),(1:nres)])

if (lines == 1) {
    lim <- c()
    sel2 <- sel
    aux <- 1:length(sel)
    coef <- 0
    for (i in 1:(length(sel)-1)) {
        a0 <- sel[i]
        a1 <- sel[i+1]
        if ((a1-a0) != 1) {
            lim <- c(lim,(a0+1))
            sel2 <- c(sel2[1:(i+coef)],(a0+1),sel2[-(1:(i+coef))])
            coef <- coef + 1
        }
    }
    sel <- sel2
#    sel <- c(sel,lim)
#    sel <- sort(sel)
    a[lim,]=NA
    a[,lim]=NA
}
a <- a[sel,sel]
a[a==1]=NA

par(mar=c(3,3,3,5.5))
image(a,axes=FALSE,col=tim.colors(64),main=paste(prot,state,"pairwise interactions window",window,sep=" "),zlim=c(0,1))
if (identical(sel0,unlist(TM))){
    mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.9)
    mtext(text=lab, side=1, line=0.3, at=pos, las=1, cex=0.9)
}
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))

if (identical(sel0,unlist(TM))){
    png(paste("sweep/sweep",prot,state,ncov,"covmat_window",window,".png",sep="_"),width=1100,height=825,res=160)
    par(mar=c(3,3,3,5.5))
    image(a,axes=FALSE,col=tim.colors(64),main=paste(prot,state,"pairwise interactions window",window,sep=" "),zlim=c(0,1))
    mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.9)
    mtext(text=lab, side=1, line=0.3, at=pos, las=1, cex=0.9)
    image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
    dev.off()
}
}
}
}