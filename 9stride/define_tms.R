#args <- commandArgs(TRUE)
#prot <- args[1]
#state <- args[2]

#for (prot in c("LeuT","Mhp1")){
#for (state in c("PRiBB","PRoBB","PRocBB")){
for (prot in "LeuT"){
for (state in "PRiBB"){

inputfile<-paste("strs/",prot,"_",state,"_str.dat",sep="")
outputfile<-paste("finalstr/",prot,"_",state,"_final_str.dat",sep="")

#if ((file.exists(inputfile)) && !(file.exists(outputfile))){

a <- read.table(inputfile)
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

write.table(out,outputfile,row.names=FALSE,col.names=FALSE)
#}
}
}