prot <- "LeuT"
state <- "PRoBB"
ncov <- 1

args<-c(ncov,1,"fixed.dcd",prot,state)
atom <- read.table(paste("mca/",prot,"/",state,"/","atom.vector",sep=""))[,1]
file_name <- paste("mca/",prot,"/",state,"/",args[1],"_",args[2],"_", args[3], ".Rdata", sep="")
if (file.exists(file_name)) {
    load(file_name)
} else {
    for (i in 1:args[1]) {
        name <- paste(i, "_", args[2], "_", args[3], ".varcov.dat", sep="")
        if (i ==1) {
            C <- try(list(as.matrix(read.table(name))))
        } else {
            C[[i]] <- try(as.matrix(read.table(name)))
        }
        if (class(C[[i]]) == "try-error") {
            print(paste("Error in matrix ", i, ".", sep=""))
        }
    }
}

require(caTools)
source("itfunctions.R")

if (prot == "LeuT") {
    nres <- 513
    shift <- 0
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
    TM1a<-c(11:22)
    TM1b<-c(25:37)
    TM6a<-c(241:255)
    TM6b<-c(261:266)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12,TM1a,TM1b,TM6a,TM6b)
    TMlab <- list("TM1","TM2","TM3","TM4","TM5","TM6","TM7","TM8","TM9","TM10","TM11","TM12","TM1a","TM1b","TM6a","TM6b")
}
if (prot == "Mhp1") {
    nres <- 461
    shift<-9
    TM1<-c(29:53)-shift
    TM2<-c(59:84)-shift
    TM3<-c(102:133)-shift
    TM4<-c(142:157)-shift
    TM5<-c(164:187)-shift
    TM6<-c(207:230)-shift
    TM7<-c(250:274)-shift
    TM8<-c(295:325)-shift
    TM9<-c(340:355)-shift
    TM10<-c(357:379)-shift
    TM1a<-c(29:40)-shift
    TM1b<-c(43:53)-shift
    TM6a<-c(207:221)-shift
    TM6b<-c(227:230)-shift
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM1a,TM1b,TM6a,TM6b)
    TMlab <- list("TM1","TM2","TM3","TM4","TM5","TM6","TM7","TM8","TM9","TM10","TM1a","TM1b","TM6a","TM6b")
}

#1:length(TM)
for (i in 1) {
    for (j in 8){
        if (j<i) next
        if (((i==1) && ((j==13) || (j==14))) && (args[4]=="LeuT")) next
        if (((i==6) && ((j==15) || (j==16))) && (args[4]=="LeuT")) next
        if (((i==1) && ((j==11) || (j==12))) && (args[4]=="Mhp1")) next
        if (((i==6) && ((j==13) || (j==14))) && (args[4]=="Mhp1")) next
        out <- NULL
        out <- mca (cov2cor(C[[1]]),TM[[i]],TM[[j]],atom)
#        print(paste("mca/",args[1],"_",args[2],"_","MCA","_",TMlab[[i]],"_",TMlab[[j]],".dat",sep=""))
        #write.table(out[[1]], file=paste("mca/",prot,"/",state,"/","d_",args[1],"_",args[2],"_","MCA","_",TMlab[[i]],"_",TMlab[[j]],".dat",sep=""))
        #write.table(out[[2]], file=paste("mca/",prot,"/",state,"/","u_",args[1],"_",args[2],"_","MCA","_",TMlab[[i]],"_",TMlab[[j]],".dat",sep=""))
        #write.table(out[[3]], file=paste("mca/",prot,"/",state,"/","v_",args[1],"_",args[2],"_","MCA","_",TMlab[[i]],"_",TMlab[[j]],".dat",sep=""))
    }
}
