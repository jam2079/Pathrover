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

#TM1a <- c(15:20)
#TM2a <- c(44:50)
#TM3 <- c(101:111)
#TM4 <- c(173:180)
#TM5b <- c(204:213)
#TM6a <- c(245:252)
#TM7 <- c(286:296)
#TM8 <- c(349:359)
#TM9 <- c(380:390)
#TM10 <- c(407:416)
#TM1b <- c(29:35)
#TM6b <- c(262:267)
#TM2b <- c(58:65)
#TM5g <- c(193:199)

TM <-list(0)
#TM2 <- c(38:74)
whole <- c(1:461)
nresan <- length(whole)-3
for (i in 1:nresan) {
#    TM[[i]]=TM2[i:(i+3)]
    TM[[i]]=whole[i:(i+3)]
}

#TM <- list(TM1a,TM2a,TM3,TM4,TM5b,TM6a,TM7,TM8,TM9,TM10,TM1b,TM6b,TM2b,TM5g)
#TM <- list(349:352,350:353,351:354,352:355,353:356,354:357,355:358,356:359)



save.image(file=file_name)

#q(save="no")

# Calculate average N-body Total Intercorrelation Correlation Coefficient

AVE_R_TCI <- try(lapply(TM, calculate.average.n.body.inter.corr, C=C[1:args[1]], atom=atom),TRUE)

# Entropy decomposition using Total Intercorrelation

#AVE_RIGID_TCI <- try(lapply(TM, calculate.average.rigid.body.inter, C=C[1:args[1]], atom=atom),TRUE)

#AVE_pairR_ALL <- try(calculate.all.frc.average.intercorrelation.coefficient(C=C[1:args[1]],TM,atom),TRUE)

#save.image(file=file_name)

#e1 <- try(write.table(AVE_R_TCI, file=paste(args[1],args[2],"AVE_R_TCI.dat",sep="_")),TRUE)
e1 <- try(write.table(AVE_R_TCI, file=paste(args[1],args[2],"KINK_AVE_R_TCI.dat",sep="_")),TRUE)

#for (i in 1:length(TM)){
#    e2 <- try(write.table(AVE_RIGID_TCI[[i]], file=paste(args[1],args[2],i,"AVE_RIGID_TCI.dat",sep="_")),TRUE)
#}

#e3 <- try(write.table(AVE_pairR_ALL, file=paste(args[1],args[2],"pairR_ALL.dat",sep="_")),TRUE)

q(save="no")
