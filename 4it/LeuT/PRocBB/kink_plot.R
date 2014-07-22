kink_plot_leut <- function(prot,state) {
    #prot<-"LeuT"
    #state<-"PRoBB"
    require(fields)
#    require(gplots)

    org<-read.table("10_1_KINK_AVE_R_TCI.dat")
    
    a <- as.matrix(org)

    
    rig <- a[seq(1,length(a),by=2)]

    nres <- length(rig)+3
    nresan <- nres-3
    whole <- c(1:nres)
    wholeplot <- whole[1:nresan]+1.5
    
    #From 2+smooth/2 to nres-1-smooth/2
    plt<-"rig"
    plt<-"try"
    #plt<-"rigvsvar"
    smooth <- 4
    minres <- 2+smooth/2
    maxres <- nres-1-smooth/2
    xi=minres
    xf=maxres
    minrig=min(rig)
    maxrig=max(rig)

    TM1<-c(11:37)
    TM2<-c(41:70)
    TM3<-c(88:124)
    TM4<-c(166:183)
    TM5<-c(191:213)
    TM6<-c(241:266)
    TM7<-c(276:306)
    TM8<-c(337:369)
    TM9<-c(375:395)
    TM10<-c(399:424)
    TM11<-c(447:477)
    TM12<-c(483:513)
    IL1<-c(77:84)
    EL2<-c(137:152)
    EL3<-c(223:231)
    EL4<-c(308:331)
    IL5<-c(429:437)
    
    b<-c(1:nresan)
    b[]=0
    b[intersect(whole,TM1)]=1
    b[intersect(whole,TM2)]=1
    b[intersect(whole,TM3)]=1
    b[intersect(whole,TM4)]=1
    b[intersect(whole,TM5)]=1
    b[intersect(whole,TM6)]=1
    b[intersect(whole,TM7)]=1
    b[intersect(whole,TM8)]=1
    b[intersect(whole,TM9)]=1
    b[intersect(whole,TM10)]=1
    b[intersect(whole,TM11)]=1
    b[intersect(whole,TM12)]=1
    c<-c(1:nresan)
    c[]=0
    c[intersect(whole,IL1)]=1
    c[intersect(whole,EL2)]=1
    c[intersect(whole,EL3)]=1
    c[intersect(whole,EL4)]=1
    c[intersect(whole,IL5)]=1
    
    ny <- c((2+smooth/2):(nres-1-smooth/2))-smooth/2-1
    nrig <- ny
    for (i in ny) {
        nrig[i]<-sum(rig[(i):(i+smooth-1)])/smooth    
    }
    nx <- c((2+smooth/2):(nres-1-smooth/2))
    
    dev<-as.matrix(read.table("10_1_KINK_AVE_DEV_TCI.dat"))
    devav<-c()
    for (i in 1:nres){
        devav[i] <- sqrt(sum(dev[(4*(i-1)+1):(4*i)]^2))
#        devav[i] <- sum(dev[(4*(i-1)+1):(4*i)])/4
    }
    devavx<-devav[nx]
    
    
    minnrig=min(nrig)
    maxnrig=max(nrig)
    
    xi=xi-1-smooth/2
    xf=xf-1-smooth/2
    reslist<-nx[xi:xf]
    coef<-nrig[xi:xf]/devavx[xi:xf]
    
    mindevavx<-min(devavx)
    maxdevavx<-max(devavx)
    #b<-b+1
    #b[b==2]<-0
    b<-b[nx]
    #devavx<-devavx*b
    #nrig<-nrig*b

    e2 <- try(write.table(reslist, file=paste("../../../proteins/",prot,"/",state,"/reslist.dat",sep="")),TRUE)
    e3 <- try(write.table(coef, file=paste("../../../proteins/",prot,"/",state,"/coef.dat",sep="")),TRUE)
}

    
    
#kink_plot_leut("PRi")
#kink_plot_leut("PRiBB")
#kink_plot_leut("PRo")
#kink_plot_leut("PRoBB")
#kink_plot_leut("PRoc")
#kink_plot_leut("PRocBB")
