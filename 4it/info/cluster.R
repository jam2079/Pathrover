rm(list=ls())
prot <- "LeuT"
state <- "PRoBB"
window <- 4
tm <- 1
#for (prot in c("LeuT","Mhp1")) {
#for (state in c("PRi","PRiBB","PRo","PRoBB","PRoc","PRocBB")) {
#for (window in 1:10) {
#for (tm in 1:10) {
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
ncov <- 3
filedat <- paste("cluster/data/cluster",prot,state,ncov,"matrices_window",window,"TM",tm,".dat",sep="_")
filepng <- paste("cluster/plots/cluster",prot,state,ncov,"matrices_window",window,"TM",tm,".png",sep="_")
#if (file.exists(filedat)) next
print(prot)
print(state)
print(window)
print(tm)
sel <- TM[[tm]]
maxk <- 10
nit <- 100

#require(fields)
#require(gplots)
#require(calibrate)
#require(zoo)

a <- try(read.table(paste(prot,"/",state,"/",ncov,"_",1,"_sweep_",window,"_.dat",sep="")),TRUE)
if ('try-error' %in% class(a)) next
a <- as.matrix(a[(1:nres),(1:nres)])
a <- a[sel,]

maxratio <- rep(0,maxk)
maxclstr <- list(0)
for (k in 1:maxk) {
    for (i in 1:nit) {
        krslt <- kmeans(a,k,iter.max=20)
        ratio <- krslt[[6]]/krslt[[3]]
        if (ratio > maxratio[k]){
            maxratio[k] <- ratio
            maxclstr[[k]] <- as.vector(krslt$cluster)
        }
    }
}

write.table(maxclstr,filedat)

png(filepng,width=1100,height=825,res=160)
par(mar=c(3,3,3,3))
title <- paste("Cluster",prot,state,ncov,"matrices window",window,"TM",tm)
plot(1:maxk,maxratio,"l",xlab="k",ylab="Ratio",ylim=c(0,1),main=title)
dev.off()

#}
#}
#}
#}
