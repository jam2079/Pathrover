rigid_mhp1 <- function(state) {
prot<-"Mhp1"    
#    setwd(paste(prot,state,sep="/"))
    a<-read.table(paste(prot,state,"10_1_AVE_R_TCI.dat",sep="/"))
    
TM <- c("TM1a","TM2a","TM3a","TM4","TM5s","TM6a","TM7a","TM8a","TM9","TM10s","TM1b","TM2b","TM3b","TM5g","TM6b","TM7b","TM8b","TM10g")
TMx <- c("1a","2a","3a","4","5s","6a","7a","8a","9","10s","1b","2b","3b","5g","6b","7b","8b","10g")
take <- c(1,11,6,15,2,12,7,16,3,13,4,8,17,9,5,10,14,18)

    a <- a[seq(1,2*length(take),by=2)]
    a=a[take]
    colnames(a) <- TMx[take]
    
    a <- as.matrix(a)
    par(ps = 14, cex.axis=0.86)
    barplot(a,ylim=c(0,1),main=paste(prot,state,"TM rigidity",sep=" "))
    abline(v=7.30)
    abline(v=12.1)
    abline(v=14.525)
    abline(v=16.9)
    
png(paste(ncovmar,"_R_",prot,"_",state,".png",sep=""))
par(ps = 14, cex = 0.815, cex.main = 1.4)
    barplot(a,ylim=c(0,1),main=paste(prot,state,"TM rigidity",sep=" "))
abline(v=7.30)
abline(v=12.1)
abline(v=14.525)
abline(v=16.9)
dev.off()
    
#    setwd("../..")
}

rigid_mhp1("PRi")
rigid_mhp1("PRiBB")
rigid_mhp1("PRo")
rigid_mhp1("PRoBB")
rigid_mhp1("PRoc")
rigid_mhp1("PRocBB")
