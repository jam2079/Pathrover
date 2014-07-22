args<-c(1,1,"fixed.dcd","Mhp1","PRiBB")
atom <- read.table("atom.vector")[,1]
#args <- commandArgs(TRUE)
file_name <- paste(args[1],"_",args[2],"_", args[3], ".Rdata", sep="")

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

source("itfunctions.R")

atom <- read.table("atom.vector")[,1]
#args <- commandArgs(TRUE)
file_name <- paste(args[1],"_",args[2], "_", args[3], ".Rdata", sep="")

require(caTools)

# Here you need to define the segments you are looking at

if (args[4] == "LeuT") {
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
    TM1a<-c(11:22)
    TM1b<-c(25:37)
    TM6a<-c(241:255)
    TM6b<-c(261:266)
    
    TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12,TM1a,TM1b,TM6a,TM6b)
    TMlab <- list("TM1","TM2","TM3","TM4","TM5","TM6","TM7","TM8","TM9","TM10","TM11","TM12","TM1a","TM1b","TM6a","TM6b")
}
if (args[4] == "Mhp1") {
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

save.image(file=file_name)


# Calculate average N-body Total Intercorrelation Correlation Coefficient
####AVE_R_TCI <- try(lapply(TM, calculate.average.n.body.inter.corr, C=C[1:args[1]], atom=atom),TRUE)
# Entropy decomposition using Total Intercorrelation
#AVE_RIGID_TCI <- try(lapply(TM, calculate.average.rigid.body.inter, C=C[1:args[1]], atom=atom),TRUE)
####AVE_pairR_ALL <- try(calculate.all.frc.average.intercorrelation.coefficient(C=C[1:args[1]],TM,atom),TRUE)

####e1 <- try(write.table(AVE_R_TCI, file=paste(args[1],args[2],"AVE_R_TCI.dat",sep="_")),TRUE)
#for (i in 1:length(TM)){
#    e2 <- try(write.table(AVE_RIGID_TCI[[i]], file=paste(args[1],args[2],i,"AVE_RIGID_TCI.dat",sep="_")),TRUE)
#}
####e3 <- try(write.table(AVE_pairR_ALL, file=paste(args[1],args[2],"pairR_ALL.dat",sep="_")),TRUE)



##############################################################
#Calculate the 4-body rigidity along the whole protein
#block4 <-list(0)
#whole <- c(1:nres)
#nresan <- nres-3
#for (i in 1:nresan) {
#    block4[[i]]=whole[i:(i+3)]
#}

#KINK_AVE_R_TCI4 <- try(lapply(block4, calculate.average.n.body.inter.corr, C=C[1:args[1]], atom=atom),TRUE)

#Calculate the 7-body rigidity along the whole protein
#block7 <-list(0)
#whole <- c(1:nres)
#nresan <- nres-6
#for (i in 1:nresan) {
#    block7[[i]]=whole[i:(i+6)]
#}

#KINK_AVE_R_TCI7 <- try(lapply(block7, calculate.average.n.body.inter.corr, C=C[1:args[1]], atom=atom),TRUE)

#Calculate variance of each atom
#natoms <- sum(atom[1:nres])
#ncov <- length(C)
#y<-matrix(0,natoms,ncov)
#for (n in 1:natoms) {
#    for (i in 1:ncov){
#        y[n,i] <- sqrt(sum(diag(C[[i]][(3*(n-1)+1):(3*n),(3*(n-1)+1):(3*n)])))
#    }
#}
#dev <- rowSums(y)/ncov

#for (sz in 1:10){
#    print(paste(sz,"started"))
#    if (!file.exists(paste(args[1],args[2],"sweep",sz,".dat",sep="_"))){
#        all <- list(0)
#        for (i in 1:(nres-sz+1)){
#            all[[i]]=c(i:(i+sz-1))
#        }
#        sweep <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:args[1]],all,atom)
#        esweep <- write.table(sweep, file=paste(args[1],args[2],"sweep",sz,".dat",sep="_"))
#    }
#    print(paste(sz,"finished"))
#}

for (i in 1:length(TM)) {
    for (j in 1:length(TM)){
        if (j<i) next
        if (((i==1) && ((j==13) || (j==14))) && (args[4]=="LeuT")) next
        if (((i==6) && ((j==15) || (j==16))) && (args[4]=="LeuT")) next
        if (((i==1) && ((j==11) || (j==12))) && (args[4]=="Mhp1")) next
        if (((i==6) && ((j==13) || (j==14))) && (args[4]=="Mhp1")) next
        out <- NULL
        out <- mca (C[[1]],TM[[i]],TM[[j]],atom)
#        print(paste("mca/",args[1],"_",args[2],"_","MCA","_",TMlab[[i]],"_",TMlab[[j]],".dat",sep=""))
        write.table(out[[1]], file=paste("mca/d_",args[1],"_",args[2],"_","MCA","_",TMlab[[i]],"_",TMlab[[j]],".dat",sep=""))
        write.table(out[[2]], file=paste("mca/u_",args[1],"_",args[2],"_","MCA","_",TMlab[[i]],"_",TMlab[[j]],".dat",sep=""))
        write.table(out[[3]], file=paste("mca/v_",args[1],"_",args[2],"_","MCA","_",TMlab[[i]],"_",TMlab[[j]],".dat",sep=""))
    }
}



#Save
#save.image(file=file_name)

#e4 <- try(write.table(KINK_AVE_R_TCI4, file=paste(args[1],args[2],"KINK_AVE_R_TCI4.dat",sep="_")),TRUE)
#e7 <- try(write.table(KINK_AVE_R_TCI7, file=paste(args[1],args[2],"KINK_AVE_R_TCI7.dat",sep="_")),TRUE)
#e5 <- try(write.table(dev, file=paste(args[1],args[2],"KINK_AVE_DEV_TCI.dat",sep="_")),TRUE)

#e6 <- try(write.table(reslist, file=paste("../../../proteins",prot,state,"reslist.dat",sep="/")),TRUE)
#e10 <- try(write.table(coef, file=paste("../../../proteins",prot,state,"coef.dat",sep="/")),TRUE)




q(save="no")
