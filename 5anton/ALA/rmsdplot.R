rmsdplot <- function(prot) {
    datfile <- paste("../rmsd/data/",prot,"_rmsd.dat",sep="")
    pngfile <- paste("../rmsd/plots/",prot,"_rmsd.png",sep="")
    
    rmsd <- as.vector(as.matrix(read.table(datfile)))

	TMx <- c("1a","2","3","4","5","6a","7","8","9","10","1b","6b","11","12")
        
        frame<-1:length(rmsd)-1
        
	if (!file.exists(pngfile)) {	
        png(pngfile,width=1100,height=825,res=160)
        title=paste(prot,"RMSD")
        plot(frame,rmsd,"l",main=title,xlab="Frame", ylab="RMSD")
        dev.off()
	}

        for (i in 1:length(TMx)) {
            datfile=paste("../rmsd/data/",prot,"_rmsd_tm_",TMx[i],".dat",sep="")
            pngfile=paste("../rmsd/plots/",prot,"_rmsd_tm_",TMx[i],".png",sep="")
	    if (file.exists(pngfile)) {next}
	    rmsdtm <- as.vector(as.matrix(read.table(datfile)))
            png(pngfile,width=1100,height=825,res=160)
            title=paste(prot,"RMSD all TMs and TM",TMx[i])
            plot(frame,rmsd,"l",main=title,xlab="Frame", ylab="RMSD")
            lines(frame,rmsdtm,col="blue")
            dev.off()
        }
}
