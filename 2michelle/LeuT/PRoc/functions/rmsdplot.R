rmsdplot <- function(prot,state,png) {
    rmsd<-read.table("rmsd/rmsd.dat")
    rmsd<-as.matrix(rmsd)
    rmsd<-as.vector(rmsd)
    
    frame<-1:length(rmsd)-1
    
    pdf("rmsd/rmsd.pdf")
    title=paste(prot," ",state," RMSD",sep="")
    plot(frame,rmsd,"l",main=title,xlab="Frame", ylab="Distance")
    dev.off()
    
    if (png) {
        png("rmsd/rmsd.png")
        plot(frame,rmsd,"l",main=title,xlab="Frame", ylab="Distance")
        dev.off()
    }
    
    
}
