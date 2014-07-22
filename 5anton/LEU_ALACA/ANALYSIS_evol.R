#boot <- 1
atom <- read.table("atom.vector")[,1]
args <- commandArgs(TRUE)
ncovmat <- 1
prot <- args[1]
nmbr <- args[2]
nmbr <- as.numeric(nmbr)
print(nmbr)
#tmtmtm <- args[3]
dcdfile <- paste(prot,nmbr,"evol_fixed_long.dcd",sep="_")

beg <- (nmbr - 1)*1000+1
end <- (nmbr + 9)*1000
if ((prot=="LEU")||(prot=="LEUBB")||(prot=="LEUSC")){from <- "LEU" }
if ((prot=="LEU")||(prot=="LEUBB")||(prot=="LEUSC")){from <- "LEU" }
if ((prot=="LEU")||(prot=="LEUBB")||(prot=="LEUSC")){from <- "LEU" }

file_name <- paste(dcdfile,".Rdata",sep="")
if (file.exists(file_name)) {
    load(file_name)
} else {
    for (i in 1:ncovmat) {
        name <- paste(beg,"_",end,".dcd.varcov.dat",sep="")
        if (i ==1) {
            C <- try(list(as.matrix(read.table(name))))
#            if ((prot == "LEUBB") || (prot == "LEU_VALBB") || (prot == "ALABB")){
#                take <- as.vector(as.matrix(read.table(paste("../BB/",from,"_BB.dat",sep=""))))
#                take <- sort(c(take*3-2,take*3-1,take*3))
#                C <- C[take,take]
#            }
#            if ((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "ALASC")){
#                take <- as.vector(as.matrix(read.table(paste("../SC/",from,"_SC.dat",sep=""))))
#                take <- sort(c(take*3-2,take*3-1,take*3))
#                C <- C[take,take]
#            }
        } else {
            C[[i]] <- try(as.matrix(read.table(name)))
#            if ((prot == "LEUBB") || (prot == "LEU_VALBB") || (prot == "ALABB")){
#                take <- as.vector(as.matrix(read.table(paste("../BB/",from,"_BB.dat",sep=""))))
#                take <- sort(c(take*3-2,take*3-1,take*3))
#                C[[i]] <- C[[i]][take,take]
#            }
#            if ((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "ALASC")){
#                take <- as.vector(as.matrix(read.table(paste("../SC/",from,"_SC.dat",sep=""))))
#                take <- sort(c(take*3-2,take*3-1,take*3))
#                C[[i]] <- C[[i]][take,take]
#            }
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
file_name <- paste(dcdfile,".Rdata",sep="")
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
if ((prot == "LEU_ALA") || (prot == "LEU_ALABB") || (prot == "LEU_ALASC")) {
    TM1a<-c(11:22)
    TM1b<-c(29:38)
    TM2<-c(41:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6a<-c(241:255)
    TM6b<-c(261:268)
    TM7<-c(275:306)
    TM8<-c(337:371)
    TM9<-c(375:395)
    TM10<-c(399:425)
    TM11<-c(446:476)
    TM12<-c(481:511)
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

rescodes<-c("M","E","V","K","R","E","H","W","A","T","R","L","G","L","I","L","A","M","A","G","N","A","V","G","L","G","N","F","L","R","F","P","V","Q","A","A","E","N","G","G","G","A","F","M","I","P","Y","I","I","A","F","L","L","V","G","I","P","L","M","W","I","E","W","A","M","G","R","Y","G","G","A","Q","G","H","G","T","T","P","A","I","F","Y","L","L","W","R","N","R","F","A","K","I","L","G","V","F","G","L","W","I","P","L","V","V","A","I","Y","Y","V","Y","I","E","S","W","T","L","G","F","A","I","K","F","L","V","G","L","V","P","E","P","P","P","N","A","T","D","P","D","S","I","L","R","P","F","K","E","F","L","Y","S","Y","I","G","V","P","K","G","D","E","P","I","L","K","P","S","L","F","A","Y","I","V","F","L","I","T","M","F","I","N","V","S","I","L","I","R","G","I","S","K","G","I","E","R","F","A","K","I","A","M","P","T","L","F","I","L","A","V","F","L","V","I","R","V","F","L","L","E","T","P","N","G","T","A","A","D","G","L","N","F","L","W","T","P","D","F","E","K","L","K","D","P","G","V","W","I","A","A","V","G","Q","I","F","F","T","L","S","L","G","F","G","A","I","I","T","Y","A","S","Y","V","R","K","D","Q","D","I","V","L","S","G","L","T","A","A","T","L","N","E","K","A","E","V","I","L","G","G","S","I","S","I","P","A","A","V","A","F","F","G","V","A","N","A","V","A","I","A","K","A","G","A","F","N","L","G","F","I","T","L","P","A","I","F","S","Q","T","A","G","G","T","F","L","G","F","L","W","F","F","L","L","F","F","A","G","L","T","S","S","I","A","I","M","Q","P","M","I","A","F","L","E","D","E","L","K","L","S","R","K","H","A","V","L","W","T","A","A","I","V","F","F","S","A","H","L","V","M","F","L","N","K","S","L","D","E","M","D","F","W","A","G","T","I","G","V","V","F","F","G","L","T","E","L","I","I","F","F","W","I","F","G","A","D","K","A","W","E","E","I","N","R","G","G","I","I","K","V","P","R","I","Y","Y","Y","V","M","R","Y","I","T","P","A","F","L","A","V","L","L","V","V","W","A","R","E","Y","I","P","K","I","M","E","E","T","H","W","T","V","W","I","T","R","F","Y","I","I","G","L","F","L","F","L","T","F","L","V","F","L","A","E","R","R","R","N","H","E","S","A","G","T","LIG","Na2","Na1")
gly <- which(rescodes=="G")

if ((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "ALASC") || (prot == "LEU_ALASC")){
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


outfile <- paste("../pairwise/evol/data/",dcdfile,"_pairR_ALL.dat",sep="")
if (!file.exists(outfile)) {
    print("Start AVE_pairR_ALL")
    print(TM[[1]])
    AVE_pairR_ALL <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:ncovmat],TM,atom)
    print("End AVE_pairR_ALL")
    save.image(file=file_name)
    print("Saved")
    write.table(AVE_pairR_ALL, file=outfile)
    print("Written")
}

nres <- 518
for (sz in c(1)) {
    outfile <- paste("../sweep/evol/data/",dcdfile,"_sweep_window_",sz,"_lig.dat",sep="")
    if (file.exists(outfile)) { next }
    print(paste(sz,"started"))
    all <- list()
    count <- 1
    for (i in 1:(nres-sz+1)){
        put <- c(i:(i+sz-1))
        if (((prot == "LEUSC") || (prot == "LEU_VALSC") || (prot == "LEU_ALASC") || (prot == "ALASC")) && (length(intersect(put,gly)) > 0)) {next}
        all[[count]]=put
        count <- count+1
    }
    print(all)
    sweep <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:ncovmat],all,atom)
    write.table(sweep, file=outfile)
    print(paste(sz,"finished"))
}


q(save="no")
