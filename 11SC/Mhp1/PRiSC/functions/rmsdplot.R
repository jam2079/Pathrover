rmsdplot <- function(prot,state,png,pdf) {
    filepng=paste("rmsd/rmsd.png")
    filepdf=paste("rmsd/rmsd.pdf")
#    if ((png && !file.exists(filepng)) || (pdf && !file.exists(filepdf)) ){
    
        rmsd<-read.table("rmsd/rmsd.dat")
        rmsd<-as.matrix(rmsd)
        rmsd<-as.vector(rmsd)
        
        TMx <- c("1a","2","3","4","5","6a","7","8","9","10","1b","6b")
        rmsdtm <- c(1:length(TMx))
        for (i in 1:length(TMx)) {
            rmsdtm[i] <- read.table(paste("rmsd/rmsd tm ",TMx[i],".dat",sep=""))
        }
        
        frame<-1:length(rmsd)-1
        
        if (pdf && !file.exists(filepdf)) {
            pdf(filepdf)
            title=paste(prot," ",state," RMSD",sep="")
            plot(frame,rmsd,"l",main=title,xlab="Frame", ylab="RMSD")
            dev.off()
        }
        
        if (png && !file.exists(filepng)) {
            png(filepng)
            title=paste(prot," ",state," RMSD",sep="")
            plot(frame,rmsd,"l",main=title,xlab="Frame", ylab="RMSD")
            dev.off()
        }
#    }
        for (i in 1:length(TMx)) {
            filepng=paste("rmsd/rmsd tm ",TMx[i],".png",sep="")
            filepdf=paste("rmsd/rmsd tm ",TMx[i],".pdf",sep="")
            if (pdf && !file.exists(filepdf)) {
                pdf(filepdf)
                title=paste(prot," ",state," RMSD all and TM ",TMx[i],sep="")
                plot(frame,rmsd,"l",main=title,xlab="Frame", ylab="RMSD")
                lines(frame,rmsdtm[[i]],col="blue")
                dev.off()
            }
            
            if (png && !file.exists(filepng)) {
                png(filepng)
                title=paste(prot," ",state," RMSD all and TM ",TMx[i],sep="")
                plot(frame,rmsd,"l",main=title,xlab="Frame", ylab="RMSD")
                lines(frame,rmsdtm[[i]],col="blue")
                dev.off()
            }
        }
}
