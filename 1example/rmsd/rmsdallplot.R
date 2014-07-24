
rmsd<-read.table("frame_rmsdall.dat")
rmsd<-as.matrix(rmsd)
rmsd<-as.vector(rmsd)

frame<-1:length(rmsd)-1

plot(frame,rmsd,type="l")
png()