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

block <-list(0)
aux <- which(atom==1)
nres <- aux[1]-1
if ((args[4] == "Mhp1") && ((args[5] == "PRoc") || (args[5] == "PRoc"))) {
    nres <- nres-1
}
whole <- c(1:nres)
nresan <- nres-3
for (i in 1:nresan) {
    block[[i]]=whole[i:(i+3)]
}


save.image(file=file_name)


# Calculate average N-body Total Intercorrelation Correlation Coefficient
KINK_AVE_R_TCI <- try(lapply(block, calculate.average.n.body.inter.corr, C=C[1:args[1]], atom=atom),TRUE)


e1 <- try(write.table(KINK_AVE_R_TCI, file=paste(args[1],args[2],"KINK_AVE_R_TCI.dat",sep="_")),TRUE)

natoms <- sum(atom[1:nres])
ncov <- length(C)
y<-matrix(0,natoms,ncov)
for (n in 1:natoms) {
    for (i in 1:ncov){
        y[n,i] <- sqrt(sum(diag(C[[i]][(3*(n-1)+1):(3*n),(3*(n-1)+1):(3*n)])))
    }
}
dev <- rowSums(y)/ncov


e2 <- try(write.table(dev, file=paste(args[1],args[2],"KINK_AVE_DEV_TCI.dat",sep="_")),TRUE)


q(save="no")
