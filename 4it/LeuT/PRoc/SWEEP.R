atom <- read.table("atom.vector")[,1]
args <- commandArgs(TRUE)
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
args <- commandArgs(TRUE)
file_name <- paste(args[1],"_",args[2], "_", args[3], ".Rdata", sep="")

require(caTools)

# Here you need to define the segments you are looking at

prot <- args[4]
state <- args[5]

if (args[4] == "LeuT") {
    nres <- 513
    TM1a<-c(13:22)
    TM2a<-c(42:51)
    TM3a<-c(90:99)
    TM4<-c(169:178)
    TM5s<-c(204:213)
    TM6a<-c(244:253)
    TM7a<-c(276:285)
    TM8a<-c(338:347)
    TM9<-c(378:387)
    TM10s<-c(414:423)
    TM11a<-c(450:459)
    TM12s<-c(487:496)
    TM1b<-c(26:35)
    TM2b<-c(56:65)
    TM3b<-c(107:116)
    TM5g<-c(193:202)
    TM6b<-c(261:270)
    TM7b<-c(289:298)
    TM8b<-c(354:363)
    TM10g<-c(398:407)
    TM11b<-c(467:476)
    TM12o<-c(501:510)
    IL1<-c(75:84)
    EL2<-c(140:149)
    EL3<-c(223:232)
    EL4a<-c(308:317)
    EL4b<-c(322:331)
    IL5<-c(428:437)
    
    TM <- list(TM1a,TM2a,TM3a,TM4,TM5s,TM6a,TM7a,TM8a,TM9,TM10s,TM11a,TM12s,TM1b,TM2b,TM3b,TM5g,TM6b,TM7b,TM8b,TM10g,TM11b,TM12o,IL1,EL2,EL3,EL4a,EL4b,IL5)
}
if (args[4] == "Mhp1") {
    nres <- 461
    shift<-9
    TM1a<-c(30:39)-shift
    TM2a<-c(59:68)-shift
    TM3a<-c(102:111)-shift
    TM4<-c(145:154)-shift
    TM5s<-c(176:185)-shift
    TM6a<-c(212:221)-shift##########
    TM7a<-c(250:259)-shift
    TM8a<-c(301:310)-shift
    TM9<-c(338:347)-shift###########
    TM10s<-c(372:381)-shift#########
    TM1b<-c(43:52)-shift
    TM2b<-c(72:81)-shift
    TM3b<-c(117:126)-shift
    TM5g<-c(164:173)-shift
    TM6b<-c(227:236)-shift##########
    TM7b<-c(264:273)-shift
    TM8b<-c(315:324)-shift
    TM10g<-c(359:368)-shift#########
    
    TM <- list(TM1a,TM2a,TM3a,TM4,TM5s,TM6a,TM7a,TM8a,TM9,TM10s,TM1b,TM2b,TM3b,TM4,TM5g,TM6b,TM7b,TM8b,TM10g)
}

save.image(file=file_name)

for (sz in 1:10){
    print(paste(sz,"started"))
    if (!file.exists(paste("../../sweep/sweep",prot,state,args[1],"covmat_window",sz,".dat",sep="_"))){
        all <- list(0)
        for (i in 1:(nres-sz+1)){
            all[[i]]=c(i:(i+sz-1))
        }
        sweep <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:args[1]],all,atom)
#        esweep <- write.table(sweep, file=paste("../../sweep/sweep",prot,state,args[1],args[2],"sweep",sz,".dat",sep="_"))
        esweep <- write.table(sweep, file=paste("../../sweep/sweep",prot,state,args[1],"covmat_window",sz,".dat",sep="_"))
    }
    print(paste(sz,"finished"))
}

q(save="no")
