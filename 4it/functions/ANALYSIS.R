boot <- 1
dcdfile <- "fixed.dcd"
atom <- read.table("atom.vector")[,1]
args <- commandArgs(TRUE)
file_name <- paste(args[1],"_",boot,"_", dcdfile, ".Rdata", sep="")
prot <- args[2]
state <- args[3]
tmtmtm <- args[4]

if (file.exists(file_name)) {
    load(file_name)
} else {
    for (i in 1:args[1]) {
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

#tmtmtm <- args[4]
rm(AVE_R_TCI)
rm(AVE_pairR_ALL)
source("itfunctions.R")

atom <- read.table("atom.vector")[,1]
args <- commandArgs(TRUE)
file_name <- paste(args[1],"_",boot, "_", dcdfile, ".Rdata", sep="")
tmtmtm <- args[4]

require(caTools)

# Here you need to define the segments you are looking at
if ((prot == "LeuT") && ((state == "PRiBB") || (state == "PRiSC") || (state == "PRi"))) {
    nres <- 513
    TM1a<-c(11:20)
    TM2<-c(44:71)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(191:215)
    TM6a<-c(243:255)
    TM7<-c(275:306)
    TM8<-c(338:370)
    TM9<-c(375:395)
    TM10<-c(398:425)
    TM11<-c(446:476)
    TM12<-c(481:507)
    TM1b<-c(29:38)
    TM6b<-c(261:268)
    
    TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)
}
if ((prot == "LeuT") && ((state == "PRoBB") || (state == "PRoSC") || (state == "PRo"))) {
    nres <- 513
    TM1a<-c(11:22)
    TM2<-c(40:72)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(187:215)
    TM6a<-c(241:255)
    TM7<-c(275:306)
    TM8<-c(338:370)
    TM9<-c(375:395)
    TM10<-c(398:425)
    TM11<-c(446:478)
    TM12<-c(483:505)
    TM1b<-c(25:38)
    TM6b<-c(261:268)
    
    TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)
}
if ((prot == "LeuT") && ((state == "PRocBB") || (state == "PRocSC") || (state == "PRoc"))) {
    nres <- 513
    TM1a<-c(11:22)
    TM2<-c(40:68)
    TM3<-c(88:124)
    TM4<-c(166:185)
    TM5<-c(187:215)
    TM6a<-c(241:255)
    TM7<-c(275:306)
    TM8<-c(338:370)
    TM9<-c(375:395)
    TM10<-c(399:425)
    TM11<-c(448:477)
    TM12<-c(481:505)
    TM1b<-c(27:38)
    TM6b<-c(261:268)
    
    TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)
}
if ((prot == "Mhp1") && ((state == "PRiBB") || (state == "PRiSC") || (state == "PRi"))) {
    nres <- 461
    TM1a<-c(20:31)
    TM2<-c(49:77)
    TM3<-c(94:128)
    TM4<-c(133:150)
    TM5<-c(153:181)
    TM6a<-c(200:211)
    TM7<-c(233:269)
    TM8<-c(287:320)
    TM9<-c(327:341)
    TM10<-c(350:374)
    TM11<-c(400:415)
    TM12<-c(419:439)
    TM1b<-c(34:43)
    TM6b<-c(215:223)
    
    TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)
}
if ((prot == "Mhp1") && ((state == "PRoBB") || (state == "PRoSC") || (state == "PRo"))) {
    nres <- 461
    TM1a<-c(20:31)
    TM2<-c(49:75)
    TM3<-c(94:127)
    TM4<-c(133:150)
    TM5<-c(152:181)
    TM6a<-c(200:211)
    TM7<-c(233:269)
    TM8<-c(287:320)
    TM9<-c(327:341)
    TM10<-c(350:374)
    TM11<-c(400:413)
    TM12<-c(419:442)
    TM1b<-c(34:44)
    TM6b<-c(215:222)
    
    TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)
}
if ((prot == "Mhp1") && ((state == "PRocBB") || (state == "PRocSC") || (state == "PRoc"))) {
    nres <- 461
    TM1a<-c(20:31)
    TM2<-c(49:77)
    TM3<-c(94:128)
    TM4<-c(133:149)
    TM5<-c(153:181)
    TM6a<-c(200:211)
    TM7<-c(233:269)
    TM8<-c(287:320)
    TM9<-c(327:341)
    TM10<-c(350:374)
    TM11<-c(400:414)
    TM12<-c(419:439)
    TM1b<-c(34:46)
    TM6b<-c(215:224)
    
    TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)
}
gly <- as.vector(as.matrix(read.table("glycines.dat")))
if ((state == "PRiSC") || (state == "PRoSC") || (state == "PRocSC")){
    for (i in 1:length(gly)) {
        for (j in 1:length(TM)) {
            if (length(intersect(gly[i],TM[[j]]))>0){ TM[[j]] <- TM[[j]][-which(TM[[j]]==gly[i])] }
        }
    }
}
save.image(file=file_name)

print("tmtmtm")
print(tmtmtm)
for (stp in 1:length(TM)){
    if (tmtmtm == stp) {
        select <- stp
        print("select")
        print(select)
        outfile <- paste("../../rigidity/data/",prot,"_",state,"_",args[1],"_",boot,"_AVE_R_TCI_",select,".dat",sep="")
        if (file.exists(outfile)) {q(save="no")}
        TMn <- list(TM[[select]])
        print("Start rigidity")
        AVE_R_TCI <- lapply(TMn, calculate.average.n.body.inter.corr, C=C[1:args[1]], atom=atom)
        print("End rigidity")
        save.image(file=file_name)
        print("Saved")
        write.table(AVE_R_TCI, file=outfile)
        print("Written")
        q(save="no")
    }
}

#if (tmtmtm < 20) {q(save="no")}

#save.image(file=file_name)

outfile <- paste("../../pairwise/data/",prot,"_",state,"_",args[1],"_",boot,"_pairR_ALL.dat",sep="")
if (!file.exists(outfile)) {
    print("Start AVE_pairR_ALL")
    print(TM[[1]])
    AVE_pairR_ALL <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:args[1]],TM,atom)
    print("End AVE_pairR_ALL")
    save.image(file=file_name)
    print("Saved")
    write.table(AVE_pairR_ALL, file=outfile)
    print("Written")
}

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

for (sz in c(1,4)) {
    outfile <- paste("../../sweep/data/sweep_",prot,"_",state,"_",args[1],"_covmat_window_",sz,"_.dat",sep="")
    if (file.exists(outfile)) { next }
    print(paste(sz,"started"))
    all <- list()
    count <- 1
    for (i in 1:(nres-sz+1)){
        put <- c(i:(i+sz-1))
        if (length(intersect(put,gly)) > 0) {next}
        all[[count]]=put
        count <- count+1
    }
    sweep <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:args[1]],all,atom)
    write.table(sweep, file=outfile)
    print(paste(sz,"finished"))
}


#Save
#save.image(file=file_name)

#e4 <- try(write.table(KINK_AVE_R_TCI4, file=paste(args[1],boot,"KINK_AVE_R_TCI4.dat",sep="_")),TRUE)
#e7 <- try(write.table(KINK_AVE_R_TCI7, file=paste(args[1],boot,"KINK_AVE_R_TCI7.dat",sep="_")),TRUE)
#e5 <- try(write.table(dev, file=paste(args[1],boot,"KINK_AVE_DEV_TCI.dat",sep="_")),TRUE)

#e6 <- try(write.table(reslist, file=paste("../../../proteins",prot,state,"reslist.dat",sep="/")),TRUE)
#e10 <- try(write.table(coef, file=paste("../../../proteins",prot,state,"coef.dat",sep="/")),TRUE)




q(save="no")
