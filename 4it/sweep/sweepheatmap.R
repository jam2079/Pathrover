rm(list=ls())
mode <- 3     #0 to see all residues, 1 to see all TMs, 2 to see only the TMs defined in aaa and bbb, 3 to see selected residues in ccc
save <- 1     #1 to save output
aaa <- c(2)      #TM1, in the left and right in mode 2
bbb <- c(2)      #TM2, in the top and bottom in mode 2
aaa <- c(1:26)     #residues to see in the left and right in mode 3
bbb <- c(60:104)     #residues to see in the top and bottom in mode 3
same <- 0
name <- "FRET"          #name of the set of the residues in ccc

ncov <- 3
#for (prot in c("LeuT","Mhp1")) {
#for (state in c("PRiBB","PRoBB","PRocBB","PRiSC","PRoSC","PRocSC")) {
#for (sz in 1) {
for (prot in c("LeuT")) {
for (state in c("PRoSC")) {
for (sz in 1) {
require(fields)
require(gplots)

if (same==1) {bbb <- aaa}
if ((mode==3) && (prot=="Mhp1")) {
    aaa <- aaa - 9
    bbb <- bbb - 9
}
datfile <-paste("data/sweep",prot,state,ncov,"covmat_window",sz,".dat",sep="_")
if (mode==2){
    ttl1 <- NULL
for (i in aaa){
    ttl1 <- paste(ttl1,i)
}
ttl2 <- NULL
for (i in bbb){
    ttl2 <- paste(ttl2,i)
}
}
if (mode==0){pngfile <-paste("plots/sweep_all",prot,state,ncov,"covmat_window",sz,".png",sep="_")}
if (mode==1){pngfile <-paste("plots/sweep",prot,state,ncov,"covmat_window",sz,".png",sep="_")}
if (mode==2){pngfile <-paste("plots/sweep_tms",ttl1,ttl2,prot,state,ncov,"covmat_window",sz,".png",sep="_")}
if (mode==3){pngfile <-paste("plots/sweep_sel",name,prot,state,ncov,"covmat_window",sz,".png",sep="_")}

if (prot=="LeuT") {rescodes<-c("M","E","V","K","R","E","H","W","A","T","R","L","G","L","I","L","A","M","A","G","N","A","V","G","L","G","N","F","L","R","F","P","V","Q","A","A","E","N","G","G","G","A","F","M","I","P","Y","I","I","A","F","L","L","V","G","I","P","L","M","W","I","E","W","A","M","G","R","Y","G","G","A","Q","G","H","G","T","T","P","A","I","F","Y","L","L","W","R","N","R","F","A","K","I","L","G","V","F","G","L","W","I","P","L","V","V","A","I","Y","Y","V","Y","I","E","S","W","T","L","G","F","A","I","K","F","L","V","G","L","V","P","E","P","P","P","N","A","T","D","P","D","S","I","L","R","P","F","K","E","F","L","Y","S","Y","I","G","V","P","K","G","D","E","P","I","L","K","P","S","L","F","A","Y","I","V","F","L","I","T","M","F","I","N","V","S","I","L","I","R","G","I","S","K","G","I","E","R","F","A","K","I","A","M","P","T","L","F","I","L","A","V","F","L","V","I","R","V","F","L","L","E","T","P","N","G","T","A","A","D","G","L","N","F","L","W","T","P","D","F","E","K","L","K","D","P","G","V","W","I","A","A","V","G","Q","I","F","F","T","L","S","L","G","F","G","A","I","I","T","Y","A","S","Y","V","R","K","D","Q","D","I","V","L","S","G","L","T","A","A","T","L","N","E","K","A","E","V","I","L","G","G","S","I","S","I","P","A","A","V","A","F","F","G","V","A","N","A","V","A","I","A","K","A","G","A","F","N","L","G","F","I","T","L","P","A","I","F","S","Q","T","A","G","G","T","F","L","G","F","L","W","F","F","L","L","F","F","A","G","L","T","S","S","I","A","I","M","Q","P","M","I","A","F","L","E","D","E","L","K","L","S","R","K","H","A","V","L","W","T","A","A","I","V","F","F","S","A","H","L","V","M","F","L","N","K","S","L","D","E","M","D","F","W","A","G","T","I","G","V","V","F","F","G","L","T","E","L","I","I","F","F","W","I","F","G","A","D","K","A","W","E","E","I","N","R","G","G","I","I","K","V","P","R","I","Y","Y","Y","V","M","R","Y","I","T","P","A","F","L","A","V","L","L","V","V","W","A","R","E","Y","I","P","K","I","M","E","E","T","H","W","T","V","W","I","T","R","F","Y","I","I","G","L","F","L","F","L","T","F","L","V","F","L","A","E","R","R","R","N","H","E","S","A","G","T","L","V","P","R")}
if (prot=="Mhp1") {rescodes<-c("M","N","S","T","P","I","E","E","A","R","S","L","L","N","P","S","N","A","P","T","R","Y","A","E","R","S","V","G","P","F","S","L","A","A","I","W","F","A","M","A","I","Q","V","A","I","F","I","A","A","G","Q","M","T","S","S","F","Q","V","W","Q","V","I","V","A","I","A","A","G","C","T","I","A","V","I","L","L","F","F","T","Q","S","A","A","I","R","W","G","I","N","F","T","V","A","A","R","M","P","F","G","I","R","G","S","L","I","P","I","T","L","K","A","L","L","S","L","F","W","F","G","F","Q","T","W","L","G","A","L","A","L","D","E","I","T","R","L","L","T","G","F","T","N","L","P","L","W","I","V","I","F","G","A","I","Q","V","V","T","T","F","Y","G","I","T","F","I","R","W","M","N","V","F","A","S","P","V","L","L","A","M","G","V","Y","M","V","Y","L","M","L","D","G","A","D","V","S","L","G","E","V","M","S","M","G","G","E","N","P","G","M","P","F","S","T","A","I","M","I","F","V","G","G","W","I","A","V","V","V","S","I","H","D","I","V","K","E","C","K","V","D","P","N","A","S","R","E","G","Q","T","K","A","D","A","R","Y","A","T","A","Q","W","L","G","M","V","P","A","S","I","I","F","G","F","I","G","A","A","S","M","V","L","V","G","E","W","N","P","V","I","A","I","T","E","V","V","G","G","V","S","I","P","M","A","I","L","F","Q","V","F","V","L","L","A","T","W","S","T","N","P","A","A","N","L","L","S","P","A","Y","T","L","C","S","T","F","P","R","V","F","T","F","K","T","G","V","I","V","S","A","V","V","G","L","L","M","M","P","W","Q","F","A","G","V","L","N","T","F","L","N","L","L","A","S","A","L","G","P","L","A","G","I","M","I","S","D","Y","F","L","V","R","R","R","R","I","S","L","H","D","L","Y","R","T","K","G","I","Y","T","Y","W","R","G","V","N","W","V","A","L","A","V","Y","A","V","A","L","A","V","S","F","L","T","P","D","L","M","F","V","T","G","L","I","A","A","L","L","L","H","I","P","A","M","R","W","V","A","K","T","F","P","L","F","S","E","A","E","S","R","N","E","D","Y","L","R","P","I","G","P","V","A","P","A","D","E","S","A","T","A","N","T","K","E","Q","N","Q","P","A","G","G","R","G","S","H","H","H","H","H","H")}

if (!file.exists(datfile)) {next}
print(prot)
print(state)
    
if ((prot == "LeuT") && ((state == "PRiBB") || (state == "PRiSC") || (state == "PRi"))) {
    nres <- 513
    TM1<-c(11:38)
    TM2<-c(44:71)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6<-c(243:268)
    TM7<-c(275:306)
    TM8<-c(338:370)
    TM9<-c(375:395)
    TM10<-c(398:425)
    TM11<-c(446:476)
    TM12<-c(481:507)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12)
}
if ((prot == "LeuT") && ((state == "PRoBB") || (state == "PRoSC") || (state == "PRo"))) {
    nres <- 513
    TM1<-c(11:38)
    TM2<-c(40:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(187:215)
    TM6<-c(241:268)
    TM7<-c(275:306)
    TM8<-c(338:370)
    TM9<-c(375:395)
    TM10<-c(398:425)
    TM11<-c(446:478)
    TM12<-c(483:505)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12)
    pos <- c(0.04,0.13,0.23,0.31,0.38,0.47,0.55,0.64,0.72,0.79,0.89,0.97)
}
if ((prot == "LeuT") && ((state == "PRocBB") || (state == "PRocSC") || (state == "PRoc"))) {
    nres <- 513
    TM1<-c(11:38)
    TM2<-c(40:68)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(187:215)
    TM6<-c(241:268)
    TM7<-c(275:306)
    TM8<-c(338:370)
    TM9<-c(375:395)
    TM10<-c(399:425)
    TM11<-c(448:477)
    TM12<-c(481:505)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12)
    pos <- c(0.04,0.12,0.22,0.30,0.38,0.47,0.55,0.65,0.73,0.8,0.88,0.96)
}
if ((prot == "Mhp1") && ((state == "PRiBB") || (state == "PRiSC") || (state == "PRi"))) {
    nres <- 461
    TM1<-c(20:43)
    TM2<-c(49:77)
    TM3<-c(94:128)
    TM4<-c(133:150)
    TM5<-c(153:181)
    TM6<-c(200:223)
    TM7<-c(233:269)
    TM8<-c(287:320)
    TM9<-c(327:341)
    TM10<-c(350:374)
    TM11<-c(400:415)
    TM12<-c(419:439)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12)
    pos <- c(0.04,0.12,0.23,0.31,0.39,0.47,0.57,0.69,0.77,0.84,0.91,0.97)
}
if ((prot == "Mhp1") && ((state == "PRoBB") || (state == "PRoSC") || (state == "PRo"))) {
    nres <- 461
    TM1<-c(20:44)
    TM2<-c(49:75)
    TM3<-c(94:127)
    TM4<-c(133:150)
    TM5<-c(152:181)
    TM6<-c(200:222)
    TM7<-c(233:269)
    TM8<-c(287:320)
    TM9<-c(327:341)
    TM10<-c(350:374)
    TM11<-c(400:413)
    TM12<-c(419:442)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12)
    pos <- c(0.04,0.12,0.22,0.31,0.39,0.47,0.57,0.69,0.77,0.84,0.90,0.96)
}
if ((prot == "Mhp1") && ((state == "PRocBB") || (state == "PRocSC") || (state == "PRoc"))) {
    nres <- 461
    TM1<-c(20:46)
    TM2<-c(49:77)
    TM3<-c(94:128)
    TM4<-c(133:149)
    TM5<-c(153:181)
    TM6<-c(200:224)
    TM7<-c(233:269)
    TM8<-c(287:320)
    TM9<-c(327:341)
    TM10<-c(350:374)
    TM11<-c(400:414)
    TM12<-c(419:439)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12)
    pos <- c(0.04,0.13,0.24,0.32,0.39,0.48,0.58,0.70,0.78,0.84,0.91,0.97)
}

a <- read.table(datfile)
a <- as.matrix(a[(1:nres),(1:nres)])

gly <- as.vector(as.matrix(read.table(paste("../glycines/",prot,"_glycines.dat",sep=""))))
if ((state == "PRiSC") || (state == "PRoSC") || (state == "PRocSC")) {
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
    sel1 <- unlist(TM[1:12])
    sel2 <- sel1
}
if (mode==2) {
    sel1 <- unlist(TM[aaa])
    sel2 <- unlist(TM[bbb])
}
if (mode==3) {
    sel1 <- aaa
    sel2 <- bbb
}

if ((state == "PRiSC") || (state == "PRoSC") || (state == "PRocSC")) {
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

#if (save==1) {png(pngfile,width=1100,height=825,res=160)}
par(mar=c(3,3,4,7))
if (mode==0) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,state,"all pairwise interactions window",sz,"\n  "))}
if (mode==1) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,state,"pairwise interactions window",sz,"\n  "))}
if (mode==2) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,state,"pairwise interactions TM",ttl1,"TM",ttl2,"window",sz,"\n  "))}
if (mode==3) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,state,"pairwise interactions res",name,"window",sz,"\n  "))}
lab <- c("1","2","3","4","5","6","7","8","9","10","11","12")
if (mode==1){
    mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.9)
    mtext(text=lab, side=1, line=0.3, at=pos, las=1, cex=0.9)
}
if (mode==2){
    labaaa <- unlist(TM[aaa])
    labbbb <- unlist(TM[bbb])
    if (prot=="Mhp1") {
        labaaa <- labaaa + 9
        labbbb <- labbbb + 9
    }
    if ((state=="PRiSC") || (state=="PRoSC") || (state=="PRocSC")) {
        labaaa <- labaaa[! labaaa %in% gly]
        labbbb <- labbbb[! labbbb %in% gly]
    }
    laba <- paste(rescodes[labaaa],labaaa,sep="")
    labb <- paste(rescodes[labbbb],labbbb,sep="")
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
    if (prot=="Mhp1") {
        labaaa <- labaaa + 9
        labbbb <- labbbb + 9
    }
    if ((state=="PRiSC") || (state=="PRoSC") || (state=="PRocSC")) {
        labaaa <- labaaa[! labaaa %in% gly]
        labbbb <- labbbb[! labbbb %in% gly]
    }
    laba <- paste(rescodes[labaaa],labaaa,sep="")
    labb <- paste(rescodes[labbbb],labbbb,sep="")
    mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.8)
    mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.8)
    mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.8)
    mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.8)
}
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
#if (save==1) {dev.off()}


#a <- t(a)
if (save==1) {png(pngfile,width=1100,height=825,res=160)
par(mar=c(3,3,4,6.5))
if (mode==0) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,state,"all pairwise interactions window",sz,"\n  "))}
if (mode==1) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,state,"pairwise interactions window",sz,"\n  "))}
if (mode==2) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,state,"pairwise interactions TM",aaa,"TM",bbb,"window",sz,"\n  "))}
if (mode==3) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,state,"pairwise interactions res",name,"window",sz,"\n  "))}
lab <- c("1","2","3","4","5","6","7","8","9","10","11","12")
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