setwd("/Volumes/aristotle/Pathrover/5anton/sweep/evol/")
rm(list=ls())
mode <- 0     #0 to see all residues, 1 to see all TMs, 2 to see only the TMs defined in aaa and bbb, 3 to see selected residues in ccc
save <- 1     #1 to save output
aaa <- c(1)      #TM1, in the left and right in mode 2
bbb <- c(4)      #TM2, in the top and bottom in mode 2
#aaa <- c(201:300)     #residues to see in the left and right in mode 3
#bbb <- c(201:310)     #residues to see in the top and bottom in mode 3
same <- 0
name <- ""          #name of the set of the residues in ccc

aaa0 <- aaa
bbb0 <- bbb
#ncovmat <- 5
for (prot in c("LEU_ALA")) {
#for (sz in 1) {
#for (prot in c("LEU_ALASC")) {
for (num in c(10:11)) {
for (sz in 1) {
require(fields)
require(gplots)
aaa <- aaa0
bbb <- bbb0

if (same==1) {bbb <- aaa}
datfile <-paste("data/",prot,"_",num,"_evol_fixed_long.dcd_sweep_window_",sz,"_lig.dat",sep="")
if (mode==2){
    ttl1 <- NULL
    for (i in aaa){
        ttl1 <- paste(ttl1,i)
    }
    ttl2 <- NULL
    for (i in bbb){
        ttl2 <- paste(ttl2,i)
    }
    aaa <- c(aaa,13)
    bbb <- c(bbb,13)
}
if (mode==0){pngfile <-paste("plots/sweep_all",prot,"num",num,"_window",sz,".png",sep="_")}
if (mode==1){pngfile <-paste("plots/sweep",prot,"num",num,"_window",sz,".png",sep="_")}
if (mode==2){pngfile <-paste("plots/sweep_tms",ttl1,ttl2,prot,"num",num,"_window",sz,".png",sep="_")}
if (mode==3){pngfile <-paste("plots/sweep_sel",name,prot,"num",num,"_window",sz,".png",sep="_")}

rescodes<-c("M","E","V","K","R","E","H","W","A","T","R","L","G","L","I","L","A","M","A","G","N","A","V","G","L","G","N","F","L","R","F","P","V","Q","A","A","E","N","G","G","G","A","F","M","I","P","Y","I","I","A","F","L","L","V","G","I","P","L","M","W","I","E","W","A","M","G","R","Y","G","G","A","Q","G","H","G","T","T","P","A","I","F","Y","L","L","W","R","N","R","F","A","K","I","L","G","V","F","G","L","W","I","P","L","V","V","A","I","Y","Y","V","Y","I","E","S","W","T","L","G","F","A","I","K","F","L","V","G","L","V","P","E","P","P","P","N","A","T","D","P","D","S","I","L","R","P","F","K","E","F","L","Y","S","Y","I","G","V","P","K","G","D","E","P","I","L","K","P","S","L","F","A","Y","I","V","F","L","I","T","M","F","I","N","V","S","I","L","I","R","G","I","S","K","G","I","E","R","F","A","K","I","A","M","P","T","L","F","I","L","A","V","F","L","V","I","R","V","F","L","L","E","T","P","N","G","T","A","A","D","G","L","N","F","L","W","T","P","D","F","E","K","L","K","D","P","G","V","W","I","A","A","V","G","Q","I","F","F","T","L","S","L","G","F","G","A","I","I","T","Y","A","S","Y","V","R","K","D","Q","D","I","V","L","S","G","L","T","A","A","T","L","N","E","K","A","E","V","I","L","G","G","S","I","S","I","P","A","A","V","A","F","F","G","V","A","N","A","V","A","I","A","K","A","G","A","F","N","L","G","F","I","T","L","P","A","I","F","S","Q","T","A","G","G","T","F","L","G","F","L","W","F","F","L","L","F","F","A","G","L","T","S","S","I","A","I","M","Q","P","M","I","A","F","L","E","D","E","L","K","L","S","R","K","H","A","V","L","W","T","A","A","I","V","F","F","S","A","H","L","V","M","F","L","N","K","S","L","D","E","M","D","F","W","A","G","T","I","G","V","V","F","F","G","L","T","E","L","I","I","F","F","W","I","F","G","A","D","K","A","W","E","E","I","N","R","G","G","I","I","K","V","P","R","I","Y","Y","Y","V","M","R","Y","I","T","P","A","F","L","A","V","L","L","V","V","W","A","R","E","Y","I","P","K","I","M","E","E","T","H","W","T","V","W","I","T","R","F","Y","I","I","G","L","F","L","F","L","T","F","L","V","F","L","A","E","R","R","R","N","H","E","S","A","G","T","LIG","Na2","Na1")
gly <- which(rescodes=="G")

if (!file.exists(datfile)) {next}
print(prot)
print(num)

nresp <- 515
nres <- 518
if ((prot == "LEU") || (prot == "LEUBB") || (prot == "LEUSC")) {
    TM1<-c(11:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6<-c(241:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:394)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:512)
    pos <- c(0.04,0.12,0.22,0.30,0.37,0.45,0.54,0.63,0.71,0.78,0.87,0.95,0.995)
}
if ((prot == "LEU_VAL") || (prot == "LEU_VALBB") || (prot == "LEU_VALSC")) {
    TM1<-c(11:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:184)
    TM5<-c(191:215)
    TM6<-c(241:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:394)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:511)
    pos <- c(0.04,0.12,0.22,0.30,0.37,0.45,0.54,0.63,0.71,0.78,0.87,0.95,0.995)
}
if ((prot == "LEU_ALA") || (prot == "LEU_ALABB") || (prot == "LEU_ALASC")) {
    TM1<-c(11:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6<-c(241:268)
    TM7<-c(275:306)
    TM8<-c(337:371)
    TM9<-c(375:395)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:511)
    pos <- c(0.04,0.12,0.22,0.30,0.37,0.45,0.54,0.63,0.71,0.78,0.87,0.95,0.995)
}
if ((prot == "ALA") || (prot == "ALABB") || (prot == "ALASC")) {
    TM1<-c(11:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6<-c(241:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:395)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:511)
}
lig <- c(516:518)
TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12,lig)

a <- read.table(datfile)
a <- as.matrix(a[(1:nres),(1:nres)])

if ((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "LEU_ALASC") || (prot == "ALASC")) {
    a <- a[(1:(dim(a)[1]-length(gly))),(1:(dim(a)[1]-length(gly)))]
    ncol <-dim(a)[2]
    for (i in 1:length(gly)) {
        b <- gly[i]
        nrow <- dim(a)[1]
        if (gly[i] != nres) {a <- rbind(a[(1:(b-1)),],rep(0,ncol),a[(b:nrow),])}
        if (gly[i] == nres) {a <- rbind(a[(1:(b-1)),],rep(0,ncol))}
    }
    nrow <-dim(a)[1]
    for (i in 1:length(gly)) {
        b <- gly[i]
        ncol <- dim(a)[2]
        if (gly[i] != nres) {a <- cbind(a[,(1:(b-1))],rep(0,nrow),a[,(b:ncol)])}
        if (gly[i] == nres) {a <- cbind(a[,(1:(b-1))],rep(0,nrow))}
    }
}
a0 <- a

if (mode==0) {
    sel1 <- 1:dim(a)[1]
    sel2 <- sel1
}
if (mode==1) {
    sel1 <- unlist(TM)
    sel2 <- sel1
}
if (mode==2) {
    sel1 <- unlist(TM[aaa])
    sel2 <- unlist(TM[bbb])
}
if (mode==3) {
    aaa <- c(aaa,unlist(TM[[13]]))
    bbb <- c(bbb,unlist(TM[[13]]))
    sel1 <- aaa
    sel2 <- bbb
}

if ((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "LEU_ALASC") || (prot == "ALASC")) {
    sel1 <- sel1[!(sel1 %in% gly)]
    sel2 <- sel2[!(sel2 %in% gly)]
}

a <- a[sel1,sel2]
a[a==1]=NA

if (mode==1){
    ncol <-dim(a)[2]
    count <- 0
    for (i in 1:(length(TM)-1)) {
        b <- which(sel1==max(TM[[i]]))
        if (length(b) < 1) {next}
        nrow <- dim(a)[1]
        count <- count+1
        a <- rbind(a[(1:(b+count-1)),],rep(NA,ncol),a[((b+count):nrow),])
    }
    nrow <-dim(a)[1]
    count <- 0
    for (i in 1:(length(TM)-1)) {
        b <- which(sel2==max(TM[[i]]))
        if (length(b) < 1) {next}
        ncol <- dim(a)[2]
        count <- count+1
        a <- cbind(a[,(1:(b+count-1))],rep(NA,nrow),a[,((b+count):ncol)])
    }
}
if (mode==2){
    ncol <-dim(a)[2]
    count <- 0
    for (i in 1:(length(aaa)-1)) {
        if (length(aaa)<2) {next}
        b <- which(sel1==max(TM[[aaa[i]]]))
        if (length(b) < 1) {next}
        nrow <- dim(a)[1]
        count <- count+1
        a <- rbind(a[(1:(b+count-1)),],rep(NA,ncol),a[((b+count):nrow),])
    }
    nrow <-dim(a)[1]
    count <- 0
    for (i in 1:(length(bbb)-1)) {
        if (length(bbb)<2) {next}
        b <- which(sel2==max(TM[[bbb[i]]]))
        if (length(b) < 1) {next}
        ncol <- dim(a)[2]
        count <- count+1
        a <- cbind(a[,(1:(b+count-1))],rep(NA,nrow),a[,((b+count):ncol)])
    }
}

a <- t(a)
nrows <- dim(a)[1]
ncols <- dim(a)[2]
pos1 <- seq(0,1,1/(nrows-1))
ncols <- dim(a)[2]
pos2 <- seq(0,1,1/(ncols-1))
beg <- 50*(num-1)
end <- 50*(num-1)+500

#if (save==1) {png(pngfile,width=1100,height=825,res=160)}
if (save==0) {
par(mar=c(3,3,4,7))
if (mode==0) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"all pairwise interactions",beg,"-",end,"ns \n  "))}
if (mode==1) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"num",num,"pairwise interactions window",sz,"\n  "))}
if (mode==2) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"num",num,"pairwise interactions TM",ttl1,"TM",ttl2,"window",sz,"\n  "))}
if (mode==3) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"num",num,"pairwise interactions res",name,"window",sz,"\n  "))}
lab <- c("1","2","3","4","5","6","7","8","9","10","11","12","LIG")
if (mode==1){
    mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.9)
    mtext(text=lab, side=1, line=0.3, at=pos, las=1, cex=0.9)
}
if (mode==2){
    labaaa <- unlist(TM[aaa])
    labbbb <- unlist(TM[bbb])
    if ((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "ALASC")) {
        labaaa <- labaaa[! labaaa %in% gly]
        labbbb <- labbbb[! labbbb %in% gly]
    }
    laba <- paste(rescodes[labaaa],labaaa,sep="")
    labb <- paste(rescodes[labbbb],labbbb,sep="")
    laba[which(laba=="LIG516")]="LIG"
    laba[which(laba=="Na2517")]="Na2"
    laba[which(laba=="Na1518")]="Na1"
    labb[which(labb=="LIG516")]="LIG"
    labb[which(labb=="Na2517")]="Na2"
    labb[which(labb=="Na1518")]="Na1"
    for (i in 1:length(TM)) {
        TM[[i]] <- TM[[i]][! TM[[i]] %in% gly]
    }
    for (i in aaa[-1]) {
        if (length(aaa)<2) {next}
        tmp <- pos2[-which(labaaa==TM[[i]][1])]
        if (length(tmp)<1) {next}
        pos2 <- tmp
    }
    for (i in bbb[-1]) {
        if (length(bbb)<2) {next}
        tmp <- pos1[-which(labbbb==TM[[i]][1])]
        if (length(tmp)<1) {next}
        pos1 <- tmp
    }
    mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.8)
    mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.8)
    mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.8)
    mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.8)
}
if (mode==3){
    labaaa <- aaa
    labbbb <- bbb
    if ((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "ALASC")) {
        labaaa <- labaaa[! labaaa %in% gly]
        labbbb <- labbbb[! labbbb %in% gly]
    }
    laba <- paste(rescodes[labaaa],labaaa,sep="")
    labb <- paste(rescodes[labbbb],labbbb,sep="")
    laba[which(laba=="LIG516")]="LIG"
    laba[which(laba=="Na2517")]="Na2"
    laba[which(laba=="Na1518")]="Na1"
    labb[which(labb=="LIG516")]="LIG"
    labb[which(labb=="Na2517")]="Na2"
    labb[which(labb=="Na1518")]="Na1"
    mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.8)
    mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.8)
    mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.8)
    mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.8)
}
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
}
#if (save==1) {dev.off()}


#a <- t(a)
if (save==1) {png(pngfile,width=1100,height=825,res=160)
par(mar=c(3,3,4,6.5))
if (mode==0) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"all pairwise interactions",beg,"-",end,"ns \n  "))}
if (mode==1) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"num",num,"pairwise interactions window",sz,"\n  "))}
if (mode==2) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"num",num,"pairwise interactions TM",aaa,"TM",bbb,"window",sz,"\n  "))}
if (mode==3) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"num",num,"pairwise interactions res",name,"window",sz,"\n  "))}
lab <- c("1","2","3","4","5","6","7","8","9","10","11","12","LIG")
if (mode==1){
    mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.9)
    mtext(text=lab, side=1, line=0.3, at=pos, las=1, cex=0.9)
}
if (mode==2){
    mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.8)
    mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.8)
    mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.8)
    mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.8)
}
if (mode==3){
    mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.7)
    mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.7)
    mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.7)
    mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.7)
}
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
dev.off()}
}
}
}

rownames(a0)<-1:nres
colnames(a0)<-1:nres

thrs <- function(t) {
    a0[a0==1]=0
    inds <- which(a0 > t, arr.ind=TRUE)
    n <- NULL
    for (i in 1:dim(inds)[1]) {
        n[i] <- a0[inds[i,1],inds[i,2]]
    }
    inds <- cbind(inds,n)
    inds <- inds[do.call(order, lapply(1:NCOL(inds), function(i) inds[, i])), ]
    rownames(inds) <- 1:dim(inds)[1]
    colnames(inds) <- c("res1","res2","corr")
    inds
}

lig <- function(t) {
    a0[a0==1]=0
    l <- dim(a0)[1]-3
    inds <- a0[l+1,(1:l)]
    sort(inds, decreasing=TRUE)[1:t]
}
na2 <- function(t) {
    a0[a0==1]=0
    l <- dim(a0)[1]-3
    inds <- a0[l+2,(1:l)]
    out <- sort(inds, decreasing=TRUE)[1:t]
    out
}
na1 <- function(t) {
    a0[a0==1]=0
    l <- dim(a0)[1]-3
    inds <- a0[l+3,(1:l)]
    sort(inds, decreasing=TRUE)[1:t]
}
