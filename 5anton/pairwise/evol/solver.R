rm(list=ls())
save <- 1
#args <- commandArgs(TRUE)
#ncovmat <- args[1]
#prot <- args[1]
#num <- args[2]
#boot <- 1

for (prot in c("LEU","LEUBB","LEUSC","LEU_VAL","LEU_VALBB","LEU_VALSC","LEU_ALA","LEU_ALABB","LEU_ALASC")){
for (num in c(1:11)){
#ncovmat <- 5
#prot <- "LEU_VALSC"

require(fields)
require(gplots)

datfile <-paste("data/",prot,"_",num,"_evol_fixed_long.dcd_pairR_ALL.dat",sep="")
pngfile <-paste("plots/",prot,"_",num,"_evol_fixed_long.dcd_pairR_ALL.png",sep="")

if (!(file.exists(datfile))) {next}
print(prot)
print(num)
d <- read.table(datfile)

TM <- c("TM1a","TM2","TM3","TM4","TM5","TM6a","TM7","TM8","TM9","TM10","TM11","TM12","TM1b","TM6b")
TMx <- c("1a","2","3","4","5","6a","7","8","9","10","11","12","1b","6b")
take <- c(1,13,6,14,2,7,3,4,8,9,5,10,11,12)
div <- dim(d)[1]

all <- as.matrix(d[1:div,1:div])
a <- as.matrix(all[take,take])
a[a==1]=NA

nrows <- dim(a)[1]
pos <- seq(0,1,1/(nrows-1))

beg <- 50*(num-1)
end <- 50*(num-1)+500
if (save==1) {png(pngfile,width=1100,height=825,res=160)}
par(mar=c(3,4,3,5.5))
image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"pairwise interactions",beg,"-",end,"ns"))
mtext(text=TM[take], side=2, line=0.3, at=pos, las=1, cex=1)
mtext(text=TMx[take], side=1, line=0.3, at=pos, las=1, cex=1)
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
abline(v=(-pos[2])/2)
abline(v=(pos[6]+pos[7])/2)
abline(v=(pos[10]+pos[11])/2)
abline(v=(pos[12]+pos[13])/2)
abline(v=(pos[14]+(pos[2]/2)))
abline(h=(-pos[2])/2)
abline(h=(pos[6]+pos[7])/2)
abline(h=(pos[10]+pos[11])/2)
abline(h=(pos[12]+pos[13])/2)
abline(h=(pos[14]+(pos[2]/2)))
if (save==1) {dev.off()}
}
}
