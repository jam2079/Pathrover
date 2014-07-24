smoothdistanceplot <- function(r1,r2,prot,state,png) {
    
    if(r2<r1){
        r3<-r1
        r1<-r2
        r2<-r3
    }
    
    name=paste("distancedata/distance ",r1," ",r2,".dat",sep="")
    f<-read.table(name)
    f<-as.matrix(f)
    f<-as.vector(f)
    nframes<-length(f)

    nf<-array(0,c(nframes-10))
    nf<-as.vector(nf)
    for(i in 1:(nframes-10)){
        nf[i]<-sum(f[(i):(i+10)])/11
    }
    
    nx<-6:(nframes-5)
    
    file=paste("smoothdistanceplots/smoothdistanceplot ",r1," ",r2,".pdf",sep="")
    pdf(file)
    title=paste(prot," ",state," smooth distance plot ",r1," ",r2,sep="")
    plot(nx,nf,"l",main=title,xlab="Frame", ylab="Distance")
    dev.off()
    
    if (png) {
        file=paste("smoothdistanceplots/smoothdistanceplot ",r1," ",r2,".png",sep="")
        png(file)
        plot(nx,nf,"l",main=title,xlab="Frame", ylab="Distance")
        dev.off()
    }
}

distanceplot <- function(r1,r2,prot,state,png) {
    
    if(r2<r1){
        r3<-r1
        r1<-r2
        r2<-r3
    }
    
    name=paste("distancedata/distance ",r1," ",r2,".dat",sep="")
    f<-read.table(name)
    f<-as.matrix(f)
    f<-as.vector(f)
    
    nframes<-length(f)
    x<-1:nframes-1
    
    file=paste("distanceplots/distanceplot ",r1," ",r2,".pdf",sep="")
    pdf(file)
    title=paste(prot," ",state," distance plot ",r1," ",r2,sep="")
    plot(x,f,"l",main=title,xlab="Frame", ylab="Distance")
    dev.off()
    
    if (png) {
        file=paste("distanceplots/distanceplot ",r1," ",r2,".png",sep="")
        png(file)
        plot(x,f,"l",main=title,xlab="Frame", ylab="Distance")
        dev.off()
    }
    
    smoothdistanceplot(r1,r2,prot,state,png)
}

alldistanceplot <- function (all,prot,state,png) {
    for (r1 in all){
        for (r2 in all) {if (r1 < r2){
            file=paste("distanceplots/distanceplot ",r1," ",r2,".png",sep="")
            if (!file.exists(file)){
                distanceplot(r1,r2,prot,state,png)                
            }
        }}
    }
}

subset <- function(site,set,prot,state,png) {
    for (r1 in site){
        for (r2 in site) {if (r1 < r2) {
            if(r2<r1){
                r3<-r1
                r1<-r2
                r2<-r3
            }
            
            file=paste("distancedata/Na1/distance ",r1," ",r2,".png",sep="")
            if (!file.exists(file)){
                
                name<-paste("distancedata/distance ",r1," ",r2,".dat",sep="")
                f<-read.table(name)
                f<-as.matrix(f)
                f<-as.vector(f)
                copy<-paste("distancedata/",set,"/distance ",r1," ",r2,".dat",sep="")
                write(f,file=copy,ncolumns=1)
                
                nframes<-length(f)
                
                nf<-array(0,c(nframes-10))
                nf<-as.vector(nf)
                for(i in 1:(nframes-10)){
                    nf[i]<-sum(f[(i):(i+10)])/11
                }
                
                nx<-6:(nframes-5)
                
                file=paste("smoothdistanceplots/",set,"/smoothdistanceplot ",r1," ",r2,".pdf",sep="")
                pdf(file)
                title=paste(prot," ",state," smooth distance plot ",r1," ",r2,sep="")
                plot(nx,nf,"l",main=title,xlab="Frame", ylab="Distance")
                dev.off()
                
                if (png) {    
                    file=paste("smoothdistanceplots/",set,"/smoothdistanceplot ",r1," ",r2,".png",sep="")
                    png(file)
                    plot(nx,nf,"l",main=title,xlab="Frame", ylab="Distance")
                    dev.off()
                }
     
                nframes<-length(f)
                x<-1:nframes-1
                
                file=paste("distanceplots/",set,"/distanceplot ",r1," ",r2,".pdf",sep="")
                pdf(file)
                title=paste(prot," ",state," distance plot ",r1," ",r2,sep="")
                plot(x,f,"l",main=title,xlab="Frame", ylab="Distance")
                dev.off()
                
                if (png) {
                    file=paste("distanceplots/",set,"/distanceplot ",r1," ",r2,".png",sep="")
                    png(file)
                    plot(x,f,"l",main=title,xlab="Frame", ylab="Distance")
                    dev.off()
                }
            }
        }}
    }
}