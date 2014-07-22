boot <- 1
atom <- read.table("atom.vector")[,1]
args <- commandArgs(TRUE)
ncovmat <- args[1]
prot <- args[2]
tmtmtm <- args[3]
dcdfile <- paste(prot,"_fixed.dcd",sep="")

file_name <- paste(ncovmat,"_",boot,"_", dcdfile, ".Rdata", sep="")
if (file.exists(file_name)) {
    load(file_name)
} else {
    for (i in 1:ncovmat) {
        name <- paste(i, "_", boot, "_", dcdfile, ".varcov.dat", sep="")
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

save.image(file=file_name)

rm(AVE_R_TCI)
rm(AVE_pairR_ALL)
source("itfunctions.R")

atom <- read.table("atom.vector")[,1]
args <- commandArgs(TRUE)
file_name <- paste(ncovmat,"_",boot, "_", dcdfile, ".Rdata", sep="")
tmtmtm <- args[4]

require(caTools)

# Here you need to define the segments you are looking at
nres <- 518
if ((prot == "LEU") || (prot == "LEUBB") || (prot == "LEUSC")) {
    TM1a<-c(11:22)
    TM1b<-c(25:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6a<-c(241:255)
    TM6b<-c(261:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:394)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:512)
}
if ((prot == "LEU_VAL") || (prot == "LEU_VALBB") || (prot == "LEU_VALSC")) {
    TM1a<-c(11:22)
    TM1b<-c(29:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:184)
    TM5<-c(191:215)
    TM6a<-c(241:255)
    TM6b<-c(261:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:394)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:511)
}
if ((prot == "ALA") || (prot == "ALABB") || (prot == "ALASC")) {
    TM1a<-c(11:22)
    TM1b<-c(29:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6a<-c(241:255)
    TM6b<-c(261:267)
    TM7<-c(275:306)
    TM8<-c(337:370)
    TM9<-c(375:395)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:511)
}
TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)

if ((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "ALASC")){
    gly <- as.vector(as.matrix(read.table(paste("../glycines/",prot,"_glycines.dat",sep=""))))
    for (i in 1:length(gly)) {
        for (j in 1:length(TM)) {
            if (length(intersect(gly[i],TM[[j]]))>0){ TM[[j]] <- TM[[j]][-which(TM[[j]]==gly[i])] }
        }
    }
}
save.image(file=file_name)

#print("tmtmtm")
#print(tmtmtm)
#for (stp in 1:length(TM)){
#    if (tmtmtm == stp) {
#        select <- stp
#        print("select")
#        print(select)
#        outfile <- paste("../rigidity/data/",prot,"_",ncovmat,"_",boot,"_AVE_R_TCI_",select,".dat",sep="")
#        if (file.exists(outfile)) {q(save="no")}
#        TMn <- list(TM[[select]])
#        print("Start rigidity")
#        AVE_R_TCI <- lapply(TMn, calculate.average.n.body.inter.corr, C=C[1:ncovmat], atom=atom)
#        print("End rigidity")
#        save.image(file=file_name)
#        print("Saved")
#        write.table(AVE_R_TCI, file=outfile)
#        print("Written")
#        q(save="no")
#    }
#}

nres <- 515
for (sz in c(1:15)) {
    outfile <- paste("../sweeprigidity/data/sweeprigidity_",prot,"_",ncovmat,"_covmat_window_",sz,".dat",sep="")
    if (file.exists(outfile)) { next }
    print(paste(sz,"started"))
    all <- list()
    count <- 1
    for (i in 1:(nres-sz+1)){
        put <- c(i:(i+sz-1))
        if (((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "ALASC")) && (length(intersect(put,gly)) > 0)) {next}
        all[[count]]=put
        count <- count+1
    }
    sweeprigidity <- lapply(all,calculate.average.n.body.inter.corr,C=C[1:ncovmat],atom=atom)
#    sweep <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:ncovmat],all,atom)
    write.table(sweeprigidity, file=outfile)
    print(paste(sz,"finished"))
}


q(save="no")
