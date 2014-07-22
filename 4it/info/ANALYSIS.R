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

if (args[4] == "LeuT") {
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
    shift=9
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


# Calculate average N-body Total Intercorrelation Correlation Coefficient
AVE_R_TCI <- try(lapply(TM, calculate.average.n.body.inter.corr, C=C[1:args[1]], atom=atom),TRUE)
# Entropy decomposition using Total Intercorrelation
#AVE_RIGID_TCI <- try(lapply(TM, calculate.average.rigid.body.inter, C=C[1:args[1]], atom=atom),TRUE)
AVE_pairR_ALL <- try(calculate.all.frc.average.intercorrelation.coefficient(C=C[1:args[1]],TM,atom),TRUE)

e1 <- try(write.table(AVE_R_TCI, file=paste(args[1],args[2],"AVE_R_TCI.dat",sep="_")),TRUE)
#for (i in 1:length(TM)){
#    e2 <- try(write.table(AVE_RIGID_TCI[[i]], file=paste(args[1],args[2],i,"AVE_RIGID_TCI.dat",sep="_")),TRUE)
#}
e3 <- try(write.table(AVE_pairR_ALL, file=paste(args[1],args[2],"pairR_ALL.dat",sep="_")),TRUE)



##############################################################
#Calculate the 4-body rigidity along the whole protein
block <-list(0)
aux <- which(atom==1)
nres <- aux[1]-1
whole <- c(1:nres)
nresan <- nres-3
for (i in 1:nresan) {
    block[[i]]=whole[i:(i+3)]
}

KINK_AVE_R_TCI <- try(lapply(block, calculate.average.n.body.inter.corr, C=C[1:args[1]], atom=atom),TRUE)

#Calculate variance of each atom
natoms <- sum(atom[1:nres])
ncov <- length(C)
y<-matrix(0,natoms,ncov)
for (n in 1:natoms) {
    for (i in 1:ncov){
        y[n,i] <- sqrt(sum(diag(C[[i]][(3*(n-1)+1):(3*n),(3*(n-1)+1):(3*n)])))
    }
}
dev <- rowSums(y)/ncov

#Save
save.image(file=file_name)

e4 <- try(write.table(KINK_AVE_R_TCI, file=paste(args[1],args[2],"KINK_AVE_R_TCI.dat",sep="_")),TRUE)
e5 <- try(write.table(dev, file=paste(args[1],args[2],"KINK_AVE_DEV_TCI.dat",sep="_")),TRUE)

e6 <- try(write.table(reslist, file=paste("../../../proteins",prot,state,"reslist.dat",sep="/")),TRUE)
e7 <- try(write.table(coef, file=paste("../../../proteins",prot,state,"coef.dat",sep="/")),TRUE)


###
#prot <- args[4]
#state <- args[5]

#if (prot == "LeuT") {
#    TMname <- c("TM1a","TM2a","TM3","TM4","TM5b","TM6a","TM7","TM8","TM9","TM10","TM1b","TM6b","TM2b","TM5g")
#    TMnamex <- c("1a","2a","3","4","5b","6a","7","8","9","10","1b","6b","2b","5g")
#    take <- c(1,11,6,12,2,13,7,3,4,8,9,5,10,14)
#}
#if (prot == "Mhp1") {
#    TMname <- c("TM1a","TM2","TM3","TM4","TM5b","TM6a","TM7","TM8","TM9","TM10b","TM1b","TM6b","TM5g","TM10g","TM8a","TM8b")
#    TMnamex <- c("1a","2","3","4","5b","6a","7","8","9","10b","1b","6b","5g","10g","8a","8b")
#    take <- c(1,11,6,12,2,7,3,4,8,9,5,10,13,14,15,16)
#}

#AVE_R_TCI <- AVE_R_TCI[seq(1,2*length(take),by=2)]
#AVE_R_TCI = AVE_R_TCI[take]
#colnames(AVE_R_TCI) <- TMnamex[take]

#AVE_R_TCI <- as.matrix(AVE_R_TCI)
#par(ps = 14, cex = 0.955, cex.main = 1.4)
#png(paste("../R_",prot,"_",state,".png",sep=""))
#barplot(AVE_R_TCI,ylim=c(0,1),main=paste(prot,state,"TM rigidity",sep=" "))
#abline(v=8.51)
#abline(v=13.3)
#abline(v=15.7)
#dev.off()

###


q(save="no")
