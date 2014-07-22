args <- commandArgs(TRUE)
prot <- args[1]

infile<-paste("../strs/tmp/",prot,"_str_tmp.dat",sep="")
outfile<-paste("../strs/",prot,"_str.dat",sep="")

if ((file.exists(infile)) && !(file.exists(outfile))){

a <- read.table(infile)
a[a=="TRUE"]="T"
str <- NULL
for (i in 1:dim(a)[2]) {
    c <- as.vector(a[,i])
    str[i] <- names(which.max(table(c)))
}

hlx <- which(str=="H")
count <- 1
set <- matrix(0,40,2)
set[1,1] <- hlx[1]
for (i in 2:length(hlx)) {
    if (hlx[i]-hlx[i-1]==1) {next}
    set[count,2]=hlx[i-1]
    count <- count +1
    set[count,1]=hlx[i]
}
set[count,2]=hlx[length(hlx)]
ind <- rowSums(set == 0) != ncol(set)
out <- set[ind, ]

write.table(out,outfile,row.names=FALSE,col.names=FALSE)

}
