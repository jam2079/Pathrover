ncovmat <- 1

args <- commandArgs(TRUE)
inp <- args[1]
if (substr(inp,4,4) != "_") {
    prot <- substr(inp,1,3)
    part <- substr(inp,4,5)
} else {
    prot <- substr(inp,1,7)
    part <- substr(inp,8,9)    
}

nmbr <- args[2]
nmbr <- as.numeric(nmbr)

print(prot)
print(part)
print(nmbr)


dcdfile <- paste(prot,part,"_",nmbr,"_evol_fixed_long.dcd",sep="")
dcdfileget <- paste("../",prot,"/",prot,"_",nmbr,"_evol_fixed_long.dcd",sep="")

beg <- (nmbr - 1)*1000+1
end <- (nmbr + 9)*1000

file_name <- paste(dcdfileget,".Rdata",sep="")
if (file.exists(file_name)) {
    load(file_name)
} else {
    for (i in 1:ncovmat) {
        name <- paste(beg,"_",end,".dcd.varcov.dat",sep="")
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

args <- commandArgs(TRUE)
inp <- args[1]
if (substr(inp,4,4) != "_") {
    prot <- substr(inp,1,3)
    part <- substr(inp,4,5)
} else {
    prot <- substr(inp,1,7)
    part <- substr(inp,8,9)    
}

nmbr <- args[2]
nmbr <- as.numeric(nmbr)

print(prot)
print(part)
print(nmbr)


dcdfile <- paste(prot,part,"_",nmbr,"_evol_fixed_long.dcd",sep="")
dcdfileget <- paste("../",prot,"/",prot,"_",nmbr,"_evol_fixed_long.dcd",sep="")

file_name <- paste(dcdfileget,".Rdata",sep="")
save.image(file=file_name)

nresp <- 516
nres <- 518
atom.vector <- read.table(paste("../",prot,"/atom.vector",sep=""))[,1]
atom.names <- as.matrix(read.table(paste("../",prot,"/atom.names",sep=""),header=FALSE,fill=TRUE))
atom.names <- atom.names[-1,]
atom.names <- atom.names[,apply(atom.names,2,function(atom.names) !all(atom.names==""))]
for (i in c((nresp+1):nres)) {
    atom.names[i,which(atom.names[i,] != "")] <- "NOPROT"
}
atom <- list(atom.vector,atom.names,part)

require(caTools)
source("itfunctions_new.R")

# Here you need to define the segments you are looking at
nres <- 518
if (prot == "LEU") {
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
if (prot == "LEU_ALA") {
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
if (prot == "LEU_VAL") {
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
if (prot == "ALA") {
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

if (part == "SC"){
    for (i in 1:length(gly)) {
        for (j in 1:length(TM)) {
            if (length(intersect(gly[i],TM[[j]]))>0){ TM[[j]] <- TM[[j]][-which(TM[[j]]==gly[i])] }
        }
    }
}

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

for (sz in c(1)) {
    outfile <- paste("../sweep/evol/data/",dcdfile,"_sweep_window_",sz,"_lig.dat",sep="")
    if (file.exists(outfile)) { next }
    print(paste(sz,"started"))
    all <- list()
    count <- 1
    for (i in 1:(nres-sz+1)){
        put <- c(i:(i+sz-1))
        if ((part == "SC") && (length(intersect(put,gly)) > 0)) {next}
        all[[count]]=put
        count <- count+1
    }
    print(all)
    sweep <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:ncovmat],all,atom)
    print("End sweep")
    save.image(file=file_name)
    write.table(sweep, file=outfile)
    print(paste(sz,"finished"))
}


q(save="no")
