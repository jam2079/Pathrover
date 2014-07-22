rigid_leut <- function(state) {
    prot<-"LeuT"
    ncovmar <- 10
    #    setwd(paste(prot,state,sep="/"))
    a<-read.table(paste(prot,"/",state,"/",ncovmar,"_1_AVE_R_TCI.dat",sep=""))
    TM <- c("TM1a","TM2a","TM3a","TM4","TM5s","TM6a","TM7a","TM8a","TM9","TM10s","TM11a","TM12s","TM1b","TM2b","TM3b","TM5g","TM6b","TM7b","TM8b","TM10g","TM11b","TM12o")
    TMx <- c("1a","2a","3a","4","5s","6a","7a","8a","9","10s","11a","12s","1b","2b","3b","5g","6b","7b","8b","10g","11b","12o")
    take <- c(1,13,6,17,2,14,7,18,3,15,4,8,19,9,5,10,16,20)#,11,21,12,22)
    div <- dim(a)[2]/2
    
    a <- a[seq(1,2*div,by=2)]
    a <- a[take]
    colnames(a) <- TMx[take]
    
    a <- as.matrix(a)
    par(ps = 14, cex.axis=0.86)
    barplot(a,ylim=c(0,1),main=paste(prot,state,"TM rigidity",sep=" "))
    abline(v=8.51)
    abline(v=13.3)
    abline(v=15.7)
    
    par(ps = 14, cex = 0.955, cex.main = 1.4)
    png(paste(ncovmar,"_R_",prot,"_",state,".png",sep=""))
    barplot(a,ylim=c(0,1),main=paste(prot,state,"TM rigidity",sep=" "))
    abline(v=8.51)
    abline(v=13.3)
    abline(v=15.7)
    dev.off()
    
    #    setwd("../..")
}

#rigid_leut("PRi")
#rigid_leut("PRiBB")
rigid_leut("PRo")
rigid_leut("PRoBB")
rigid_leut("PRoc")
rigid_leut("PRocBB")
