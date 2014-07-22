get.list <- function(i, atom) {
    if (i > 1) {
        previous <- sum(atom[0:(i - 1)])
    } else {
        previous <- 0
    }
    (3*(previous) + 1):(3*(previous) + 3*atom[i])
}

entropy <- function(C, i, atom) {
    Li <- NULL
    for (m in i) {
        Li <- c(Li, get.list(m, atom))
    }
    if (length(Li) > 1) {
        H <- 0.5*determinant(C[Li, Li], logarithm = TRUE)[[1]][1]
    } else {
        H <- 0.5*log(C[Li,Li])
    }
    0.5*length(Li)*(1 + log(2*pi)) + H
}

conditional.entropy <- function(C, i, j, atom) {
    i <- setdiff(i, j)
    Hij <- entropy(C, c(i, j), atom)
    Hj <- entropy(C, j, atom)
    Hij - Hj
}

information <- function(C, i, j, atom) {
    ij <- intersect(i,j)
    i <- setdiff(i, ij)
    j <- setdiff(j, ij)
    Li <- NULL
    Hi <- entropy(C, i, atom)
    Hj <- entropy(C, j, atom)
    Hij <- entropy(C, c(i,j), atom)
    if (length(i) < 1) {
        NaN
    } else {
        Hi + Hj - Hij
    }
}
total.information <- function(C, i, atom) {
    Li <- NULL
    sumH <- 0
    for (m in i) {
        sumH <- sumH + entropy(C, m, atom)
    }
    H <- entropy(C, i, atom)
    sumH - H
}

partial.information <- function(C, i, j, k, atom) {
    ij <- union(k, intersect(i,j))
    i <- setdiff(i, ij)
    j <- setdiff(j, ij)
    if (length(k) > 0) {
        Hi <- conditional.entropy(C, i, k, atom)
        Hj <- conditional.entropy(C, j, k, atom)
        Hij <- conditional.entropy(C, c(i, j), k, atom)
        Hi + Hj - Hij
    } else {
        NaN
    }
}
partial.total.information <- function(C, i, j, atom) {
    Lj <- NULL
    i <- setdiff(i, j)
    sumH <- 0
    for (m in i) {
        sumH <- sumH + conditional.entropy(C, m, j, atom)
    }
    H <- conditional.entropy(C, i, j, atom)
    sumH - H
}
co.information <- function(C, i, j, k, atom) {
    part <- partial.information(C, i, j, k, atom) 
    total <- information(C, i, j, atom)
    total - part
}

coordination.information <- function(C, i, j ,atom) {
    total.information(C, i , atom) - partial.total.information(C, i, j, atom)
}

partial.coordination.information <- function(C, i, j, k, atom) {
    i <- setdiff(i, k)
    (partial.total.information(C, i, k, atom) -  partial.total.information(C, i, union(j,k), atom))
}


mutual.coordination.information <- function(C, i, j, k, atom) {
    coordination.information(C, i, j, atom) - partial.coordination.information(C, i, j, k, atom)
}

mutual.channel <- function(C, i, j, atom) {
    seq <- 1:length(atom)
    score <- sapply(seq, co.information, C = C, i = i, j = j, atom=atom)
    score
}

coordination.channel <- function(C, i, j, atom) {
    seq <- 1:length(atom)
    score <- sapply(seq, mutual.coordination.information, C=C, i=i, j=j, atom=atom)
    score
}

normalized.co.information <- function(C, i, j, k, atom) {
    co.information(C, i, j, k, atom)/information(C, i, j, atom)
}

normalized.coordination.information <- function(C, i, j, atom) {
    coordination.information(C, i, j, atom)/total.information(C, i, atom)
}

normalized.mutual.coordination.information <- function(C, i, j, k, atom) {
    mutual.coordination.information(C, i, j, k, atom)/coordination.information(C, i, j, atom)
}
calculate.all.mutual <- function(S, C, atom) {
    output_mean <- matrix(ncol = length(S), nrow = length(S), 0)
    output_sd <- matrix(ncol = length(S), nrow = length(S), 0)
    for (i in 1:length(S)) {
        for (j in 1:length(S)) {
            if (i == j) {
                output_mean[i,j] <- mean(unlist(lapply(C, entropy, i=S[[i]], atom=atom)))
                output_sd[i,j] <-sd(unlist(lapply(C, entropy, i=S[[i]], atom=atom)))
            } else {
                output_mean[i,j] <- mean(unlist(lapply(C, information, i=setdiff(S[[i]],S[[j]]), j=setdiff(S[[j]],S[[i]]), atom=atom)))
                output_sd[i,j] <- sd(unlist(lapply(C, information, i=setdiff(S[[i]],S[[j]]), j=setdiff(S[[j]],S[[i]]), atom=atom)))
            }
        }
    }
    list(output_mean, output_sd)
}

calculate.all.coordination <- function(S, C, atom) {
    output_mean <- matrix(ncol = length(S), nrow = length(S), 0)
    output_sd <- matrix(ncol = length(S), nrow = length(S), 0)
    for (i in 1:length(S)) {
        for (j in 1:length(S)) {
            if (i == j) {
                output_mean[i,j] <- mean(unlist(lapply(C, total.information, i=S[[i]], atom=atom)))
                output_sd[i,j] <-sd(unlist(lapply(C, total.information, i=S[[i]], atom=atom)))
            } else {
                output_mean[i,j] <- mean(unlist(lapply(C, normalized.coordination.information, i=setdiff(S[[i]],S[[j]]), j=setdiff(S[[j]],S[[i]]), atom=atom)))
                output_sd[i,j] <- sd(unlist(lapply(C, normalized.coordination.information, i=setdiff(S[[i]],S[[j]]), j=setdiff(S[[j]],S[[i]]), atom=atom)))
            }
        }
    }
    list(output_mean, output_sd)
}
calculate.total.contribution <- function(C, i, atom) {
    contribution <- function(C, i, j, atom) {
        1 - partial.total.information(C, i, j, atom)/total.information(C, i, atom)
    }
    contribution.mean <- function(C, i, j, atom) {
        mean(unlist(lapply(C, contribution, i=i, j=j, atom=atom))) 
    }
    contribution.sd <- function(C, i, j, atom) {
        sd(unlist(lapply(C, contribution, i=i, j=j, atom=atom))) 
    }
    result_mean <- sapply(i, contribution.mean, C=C, i=i, atom=atom)
    result_sd <- sapply(i, contribution.sd, C=C, i=i, atom=atom)
    list(result_mean, result_sd)
}

calculate.average.contribution.coordination <- function(C, i, j, atom) {
    contribution <- function(C, i, j, k, atom) {
        1 - partial.coordination.information(C, i, j, k, atom)/coordination.information(C, i, j, atom)
    }
    contribution.mean <- function(C, i, j, k, atom) {
        mean(unlist(lapply(C, contribution, i=i, j=j, k=k, atom=atom))) 
    }
    contribution.sd <- function(C, i, j, k, atom) {
        sd(unlist(lapply(C, contribution, i=i, j=j, k=k, atom=atom))) 
    }
    result_mean <- sapply(unique(c(i,j)), contribution.mean, C=C, i=i, j=j, atom=atom)
    result_sd <- sapply(unique(c(i,j)), contribution.sd, C=C, i=i, j=j, atom=atom)
    list(result_mean, result_sd)
}

calculate.average.contribution.mutual <- function(C, i, j, atom) {
    contribution <- function(C, i, j, k, atom) {
        1 - partial.information(C, i, j, k, atom)/information(C, i, j, atom)
    }
    contribution.mean <- function(C, i, j, k, atom) {
        mean(unlist(lapply(C, contribution, i=i, j=j, k=k, atom=atom))) 
    }
    contribution.sd <- function(C, i, j, k, atom) {
        sd(unlist(lapply(C, contribution, i=i, j=j, k=k, atom=atom))) 
    }
    result_mean <- sapply(unique(c(i,j)), contribution.mean, C=C, i=i, j=j, atom=atom)
    result_sd <- sapply(unique(c(i,j)), contribution.sd, C=C, i=i, j=j, atom=atom)
    list(result_mean, result_sd)
}

calculate.average.coordination.channel <- function(C, i, j, atom) {
    data <- NULL
    for (k in 1:length(C)) {
        data <- rbind(data, coordination.channel(C[[k]], i, j, atom)) 
    }
    list(apply(data, 2, mean), apply(data, 2, sd))
}

calculate.average.mutual.channel <- function(C, i, j, atom) {
    data <- NULL
    for (k in 1:length(C)) {
        data <- rbind(data, mutual.channel(C[[k]], i, j, atom)) 
    }
    list(apply(data, 2, mean), apply(data, 2, sd))
}

find.extremes <- function(Y) {
    not.na <- length(Y[!is.na(Y)])
    middle <- floor(not.na/2) + length(Y[is.na(Y)])
    Z <- cbind(1:not.na, sort(Y, decreasing = TRUE))
    model <- lm(Z[((middle-100):(middle+100)),2] ~ Z[((middle-100):(middle+100)),1])
    cut <- sqrt(sum(model$residuals^2))
    fit <- model$coefficients[1] + model$coefficients[2]*1:not.na
    order(Y, decreasing=TRUE)[1:length(which(sort(Y, decreasing = TRUE) > fit + cut))]
}

max.total.correlation.full.resolution <- function(i) {
    maxM <- nearPD(matrix(ncol = i, nrow = i, 1))$mat
    0.5*(sum(log(diag(maxM))) - determinant(maxM, logarithm=TRUE)[[1]][1])	
}

total.correlation.full.resolution <- function(C, i, atom) {
    Li <- NULL
    for (m in i) {
        Li <- c(Li, get.list(m, atom))
    }
    sum(0.5*log(2*pi*exp(1)*diag(C[Li, Li]))) - entropy(C, i, atom)
}

conditional.total.correlation.full.resolution <- function(C, i, j, atom) {
    ij <- intersect(i,j)
    i <- setdiff(i, ij)
    j <- setdiff(j, ij)
    Li <- NULL
    for (m in i) {
        Li <- c(Li, get.list(m, atom))
    }
    Lj <- NULL
    for (m in j) {
        Lj <- c(Lj, get.list(m, atom))
    }
    sumH <- 0
    for (k in Li) {
        sumH = sumH + 0.5*(length(Lj) + 1)*(1 + log(2*pi)) + 0.5*determinant(C[c(k,Lj), c(k,Lj)], logarithm = TRUE)[[1]][1] - entropy(C, j, atom)
    }
    sumH - conditional.entropy(C, i, j, atom)
}


total.intercorrelation <- function(C, i, j, atom) {
    ij <- intersect(i,j)
    i <- setdiff(i, ij)
    j <- setdiff(j, ij)
    total.correlation.full.resolution(C, c(i,j), atom) - conditional.total.correlation.full.resolution(C, i, j, atom) - conditional.total.correlation.full.resolution(C, j, i, atom)
}

conditional.total.intercorrelation <- function(C, i, j, k, atom) {
    ijk <- intersect(i, intersect(j,k))
    i <- setdiff(i, ijk)
    j <- setdiff(j, ijk)
    k <- setdiff(k, ijk)
    conditional.total.correlation.full.resolution(C, c(i,j), k, atom) -  conditional.total.correlation.full.resolution(C, i, c(j,k), atom) - conditional.total.correlation.full.resolution(C, j, c(i,k), atom)
}

n.body.marginal <- function(C, i, j, atom) {
    n <- length(j)
    if (n > 1) {
        n.body.marginal(C, i, j[1:(n-1)], atom) + n.body.conditional.marginal(C, i, j[1:(n-1)], j[n], atom)
    } else {
        sum.marginal(C, unlist(i), atom) - conditional.sum.marginal(C, unlist(i), unlist(j), atom)
    }
}

n.body.conditional.marginal <- function(C, i, j, k, atom) {
    n <- length(j)
    if (n > 1) {
        n.body.conditional.marginal(C, i, j[1:(n-1)], k, atom) - n.body.conditional.marginal(C, i, j[1:(n-1)], append(j[n], k), atom)
    } else {
        conditional.sum.marginal(C, unlist(i), unlist(k), atom) - conditional.sum.marginal(C, unlist(i), unlist(append(j,k)), atom)
    }
}

sum.marginal <- function(C, i, atom) {
    Li <- NULL
    for (m in i) {
        Li <- c(Li, get.list(m, atom))
    }
    sum(0.5*log(2*pi*exp(1)*diag(C[Li, Li])))
}

conditional.sum.marginal <- function(C, i, j, atom) {
    ij <- intersect(i,j)
    i <- setdiff(i, ij)
    j <- setdiff(j, ij)
    Li <- NULL
    for (m in i) {
        Li <- c(Li, get.list(m, atom))
    }
    Lj <- NULL
    for (m in j) {
        Lj <- c(Lj, get.list(m, atom))
    }
    sumH <- 0
    for (k in Li) {
        sumH = sumH + 0.5*(length(Lj) + 1)*(1 + log(2*pi)) + 0.5*determinant(C[c(k,Lj), c(k,Lj)], logarithm = TRUE)[[1]][1] - entropy(C, j, atom)
    }
    sumH
} 

n.body.total.intercorrelation.lookup <- function(C, i, atom, lookup.new=FALSE) {
    if( lookup.new==TRUE) {
        lookup_hash <<- i
        combo_names <- NULL
        for (j in 1:length(i)) {
            combo_names <- c(combo_names, apply(combs(1:length(i), j), 1, toString))
        }
        l_matrix <- cbind(combo_names, rep(0, length(combo_names)))
        lookup_tmp <- list(l_matrix)
        for (j in 2:length(i)) {
            lookup_tmp[[j]] <- l_matrix
        }
        lookup <<- lookup_tmp
    } else {
        lookup_tmp <- lookup
    }
    n <- length(i)
    k <- unlist(lapply(i, which.list, L=lookup_hash))
    if (as.numeric(lookup[[1]][which(lookup[[1]][,1]==toString(k)),2])==0) {  
        if (n > 1) { 
            tmp <- n.body.total.intercorrelation.lookup(C, i[1:(n - 1)], atom) - conditional.n.body.total.intercorrelation.lookup(C, i[1:(n-1)], i[n], atom) + n.body.marginal(C, i[n], i[1:(n-1)], atom)
            lookup_tmp <- lookup
            lookup_tmp[[1]][which(lookup[[1]][,1]==toString(k)),2] <- tmp
        } else {
            lookup_tmp[[1]][which(lookup[[1]][,1]==toString(k)),2] <- total.correlation.full.resolution(C, unlist(i), atom)
        }
        lookup <<- lookup_tmp
    }
    as.numeric(lookup[[1]][which(lookup[[1]][,1]==toString(k)),2])    
}

conditional.n.body.total.intercorrelation.lookup <- function(C, i, j, atom) {
    n <- length(i)
    m <- length(j) + 1
    lookup_tmp <- lookup
    k <- unlist(lapply(append(i, j), which.list, L=lookup_hash))
    if (as.numeric(lookup[[m]][which(lookup[[m]][,1]==toString(k)),2])==0) {
        if (n > 1) {
            tmp <- conditional.n.body.total.intercorrelation.lookup(C, i[1:(n -1)], j, atom) - conditional.n.body.total.intercorrelation.lookup(C, i[1:(n -1)], append(i[n], j,), atom) 
            lookup_tmp[[m]][which(lookup[[m]][,1]==toString(k)),2] <- tmp
        } else {
            lookup_tmp[[m]][which(lookup[[m]][,1]==toString(k)),2] <- conditional.total.correlation.full.resolution(C, unlist(i), unlist(j), atom)
        }
        lookup <<- lookup_tmp
    } 
    as.numeric(lookup[[m]][which(lookup[[m]][,1]==toString(k)),2])
}

n.body.correlation <- function(C, i, atom) {
    i <- unique(i)
    Li <- NULL
    for (m in i) {
        Li <- c(Li, get.list(m, atom))
    }
    
    info <- n.body.total.intercorrelation.lookup(C, i, atom, lookup.new=TRUE)
    sqrt(1 - exp(-2*info/(length(Li) - 1)))
}

information <- function(C, i, j, atom) {
    ij <- intersect(i,j)
    i <- setdiff(i, ij)
    j <- setdiff(j, ij)
    Li <- NULL
    Hi <- entropy(C, i, atom)
    Hj <- entropy(C, j, atom)
    Hij <- entropy(C, c(i,j), atom)
    if (length(i) < 1) {
        NaN
    } else {
        Hi + Hj - Hij
    }
}

conditional.information <- function(C, i, j, k, atom) {
    ij <- union(k, intersect(i,j))
    i <- setdiff(i, ij)
    j <- setdiff(j, ij)
    if (length(k) > 0) {
        Hi <- conditional.entropy(C, i, k, atom)
        Hj <- conditional.entropy(C, j, k, atom)
        Hij <- conditional.entropy(C, c(i, j), k, atom)
        Hi + Hj - Hij
    } else {
        NaN
    }
}

n.body.information.lookup <- function(C, i, atom, lookup.new=FALSE) {
    if( lookup.new==TRUE) {
        combo_names <- NULL
        for (j in 1:length(i)) {
            combo_names <- c(combo_names, apply(combs(i, j), 1, toString))
        }
        l_matrix <- cbind(combo_names, rep(0, length(combo_names)))
        lookup_tmp <- list(l_matrix)
        for (j in 2:length(i)) {
            lookup_tmp[[j]] <- l_matrix
        }
        lookup <<- lookup_tmp
    } else {
        lookup_tmp <- lookup
    }
    n <- length(i)
    if (as.numeric(lookup[[1]][which(lookup[[1]][,1]==toString(i)),2])==0) {  
        if (n > 1) { 
            tmp <- n.body.information.lookup(C, i[1:(n - 1)], atom) - conditional.n.body.information.lookup(C, i[1:(n-1)], i[n], atom)
            lookup_tmp <- lookup
            lookup_tmp[[1]][which(lookup[[1]][,1]==toString(i)),2] <- tmp
        } else {
            lookup_tmp[[1]][which(lookup[[1]][,1]==toString(i)),2] <- entropy(C, i, atom)
        }
        lookup <<- lookup_tmp
    }
    as.numeric(lookup[[1]][which(lookup[[1]][,1]==toString(i)),2])	
}

conditional.n.body.information.lookup <- function(C, i, j, atom) {
    n <- length(i)
    m <- length(j) + 1
    lookup_tmp <- lookup
    if (as.numeric(lookup[[m]][which(lookup[[m]][,1]==toString(c(i,j))),2])==0) {
        if (n > 1) {
            tmp <- conditional.n.body.information.lookup(C, i[1:(n -1)], j, atom) - conditional.n.body.information.lookup(C, i[1:(n -1)], c(i[n], j), atom) 
            lookup_tmp[[m]][which(lookup[[m]][,1]==toString(c(i,j))),2] <- tmp
        } else {
            lookup_tmp[[m]][which(lookup[[m]][,1]==toString(c(i,j))),2] <- conditional.entropy(C, i, j, atom)
        }
        lookup <<- lookup_tmp
    } 
    as.numeric(lookup[[m]][which(lookup[[m]][,1]==toString(c(i,j))),2])
}

entropy.ave.terms.lookup <- function(C, i, atom) {
    combo_names <- NULL
    for (j in 1:length(i)) {
        combo_names <- c(combo_names, apply(combs(i, j), 1, toString))
    }
    l_matrix <- cbind(combo_names, rep(0, length(combo_names)))
    lookup_tmp <- list(l_matrix)
    for (j in 2:length(i)) {
        lookup_tmp[[j]] <- l_matrix
    }
    lookup <<- lookup_tmp
    terms <- matrix(nrow=length(i), ncol=1, 0)
    for (j in seq(1, length(i), 1) ) {
        combinations <- combs(i, j)
        sum <- 0
        for (k in 1:nrow(combinations)) {
            if (j==length(i) & k==1) {
                sum <- sum + n.body.information.lookup(C, combinations[k,], atom, lookup.new=TRUE)
            } else {
                sum <- sum + n.body.information.lookup(C, combinations[k,], atom)
            }
        }
        terms[j] <- sum
    }
    numb.terms <- sapply(1:length(i), choose, n=length(i))
    terms/numb.terms
}

entropy.ave.terms.norm.lookup <- function(C, i, atom) {
    combo_names <- NULL
    for (j in 1:length(i)) {
        combo_names <- c(combo_names, apply(combs(i, j), 1, toString))
    }
    l_matrix <- cbind(combo_names, rep(0, length(combo_names)))
    lookup_tmp <- list(l_matrix)
    for (j in 2:length(i)) {
        lookup_tmp[[j]] <- l_matrix
    }
    lookup <<- lookup_tmp
    terms <- matrix(nrow=length(i), ncol=1, 0)
    for (j in seq(1, length(i), 1) ) {
        combinations <- combs(i, j)
        sum <- 0
        for (k in 1:nrow(combinations)) {
            if (j==length(i) & k==1) {
                sum <- sum + n.body.information.lookup(C, combinations[k,], atom, lookup.new=TRUE)
            } else {
                sum <- sum + n.body.information.lookup(C, combinations[k,], atom)
            }
        }
        terms[j] <- sum
    }
    numb.terms <- sapply(1:length(i), choose, n=length(i))
    terms/(numb.terms*3*min(atom[i]))
}

entropy.ave.terms.total.intercorrelation.norm.lookup <- function(C, i, atom) {
    combo_names <- NULL
    for (j in 1:length(i)) {
        combo_names <- c(combo_names, apply(combs(i, j), 1, toString))
    }
    l_matrix <- cbind(combo_names, rep(0, length(combo_names)))
    lookup_tmp <- list(l_matrix)
    for (j in 1:length(i)) {
        lookup_tmp[[j]] <- l_matrix
    }
    lookup <<- lookup_tmp
    terms <- matrix(nrow=length(i), ncol=1, 0)
    for (j in seq(1, length(i), 1) ) {
        combinations <- combs(i, j)
        sum <- 0
        for (k in 1:nrow(combinations)) {
            normalization <- (3*sum(atom[combinations[k,]]) - 1)
            if (j==length(i) & k==1) {
                sum <- sum + n.body.total.intercorrelation.lookup(C, combinations[k,], atom, lookup.new=TRUE)/normalization
            } else {
                sum <- sum + n.body.total.intercorrelation.lookup(C, combinations[k,], atom)/normalization
            }
        }
        terms[j] <- sum
    }
    numb.terms <- sapply(1:length(i), choose, n=length(i))
    terms/numb.terms
}

rigid.body.characteristics <- function(C, i, atom) {
    ave.terms <- entropy.ave.terms.lookup(C, i, atom)
    y <- ave.terms[2:length(i)]
    x <- 2:length(i) - 2
    data <- list(x,y)
    names(data) <- c("x", "y")
    model <- nls(y ~ maxInfo * exp(-decayRate * x) + NbodyInfo, start=list(maxInfo=y[1], decayRate=1, NbodyInfo=y[length(y)]), data=data)
    output <- c(y[1], y[length(y)], 1/coef(model)[2], y[length(y)]/y[1])
    names(output) <- c("Average 2-body Information", paste("Average ", length(i), "-body Information", sep=""), "Mean Lifetime", paste("Fraction ", length(i), "-body Information", sep ="")) 
    newdata <- list(1:length(i) - 2)
    names(newdata) <- c("x")
    list(predict(model, newdata), output)
}

rigid.body.characteristics.total.intercorrelation <- function(C, i, atom) {
    ave.terms <- entropy.ave.terms.total.intercorrelation.norm.lookup(C, i, atom)
    y <- ave.terms
    x <- 1:length(i) - 1
    data <- list(x,y)
    names(data) <- c("x", "y")
    model <- try(nls(y ~ maxInfo * exp(-decayRate * x) + NbodyInfo, start=list(maxInfo=y[1], decayRate=1, NbodyInfo=y[length(y)]), data=data))
    if (class(model) != "try-error") {
        output <- c(y[1], y[length(y)], 1/coef(model)[2], y[length(y)]/y[1])
        names(output) <- c("Average 1-body Total Intercorrelation", paste("Average ", length(i), "-body Total Intercorrelation", sep=""), "Mean Lifetime", paste("Fraction ", length(i), "-body Total Intercorrelation", sep ="")) 	
        newdata <- list(1:length(i) - 1)
        names(newdata) <- c("x")
        list(predict(model, newdata), output)
    } else {
        print("Data does not fit exponential decay. Check for multiple rigid bodies or a completely disordered systems.")
        y
    }
}

n.body.inter.corr <- function(C, i, atom) {
    info <- n.body.total.intercorrelation.lookup(C, i, atom, lookup.new=TRUE)
    sqrt(1 - exp((-2*info)/(3*sum(atom[unique(unlist(i))]) - 1)))
}

calculate.average.n.body.inter.corr <- function(C, i, atom) {
    output_mean <- mean(unlist(lapply(C, n.body.inter.corr, i=i, atom=atom)))
    output_sd <- sd(unlist(lapply(C, n.body.inter.corr, i=i, atom=atom)))
    list(output_mean, output_sd)
}

n.body.info.corr <- function(C, i, atom) {
    info <- n.body.information.lookup(C, i, atom, lookup.new=TRUE)
    sqrt(1 - exp((-2*info)/(3*min(atom[unique(unlist(i))]))))
}


calculate.average.n.body.info.corr <- function(C, i, atom) {
    output_mean <- mean(unlist(lapply(C, n.body.info.corr, i=i, atom=atom)))
    output_sd <- sd(unlist(lapply(C, n.body.info.corr, i=i, atom=atom)))
    list(output_mean, output_sd)
}

rigid.body.characteristics.2 <- function(C, i, atom) {
    ave.terms <- entropy.ave.terms.norm.lookup(C, i, atom)
    y <- ave.terms[2:length(i)]
    x <- 2:length(i) - 2
    data <- list(x,y)
    names(data) <- c("x", "y")
    model <- nls(y ~ maxInfo * exp(-decayRate * x) + NbodyInfo, start=list(maxInfo=y[1], decayRate=1, NbodyInfo=y[length(y)]), data=data)
    output <- c(y[1], y[length(y)], 1/coef(model)[2], y[length(y)]/y[1])
    names(output) <- c("Average 2-body Information", paste("Average ", length(i), "-body Information", sep=""), "Mean Lifetime", paste("Fraction ", length(i), "-body Information", sep ="")) 	
    newdata <- list(1:length(i) - 2)
    names(newdata) <- c("x")
    output
}

rigid.body.characteristics.total.intercorrelation.2 <- function(C, i, atom) {
    ave.terms <- entropy.ave.terms.total.intercorrelation.norm.lookup(C, i, atom)
    y <- ave.terms[2:length(i)]
    x <- 2:length(i) - 2
    data <- list(x,y)
    names(data) <- c("x", "y")
    model <- try(nls(y ~ maxInfo * exp(-decayRate * x) + NbodyInfo, start=list(maxInfo=y[1], decayRate=1, NbodyInfo=y[length(y)]), data=data))
    if (class(model) != "try-error") {
        output <- c(y[1], y[length(y)], 1/coef(model)[2], y[length(y)]/y[1])
        names(output) <- c("Average 1-body Total Intercorrelation", paste("Average ", length(i), "-body Total Intercorrelation", sep=""), "Mean Lifetime", paste("Fraction ", length(i), "-body Total Intercorrelation", sep ="")) 	
        newdata <- list(2:length(i) - 2)
        names(newdata) <- c("x")
        output
    } else {
        print("Data does not fit exponential decay. Check for multiple rigid bodies or a completely disordered systems.")
        y
    }
}

rigid.body.characteristics.total.intercorrelation.3 <- function(C, i, atom) {
    ave.terms <- entropy.ave.terms.total.intercorrelation.norm.lookup(C, i, atom)
    y <- ave.terms
    x <- 2:length(i) - 2
    data <- list(x,y)
    names(data) <- c("x", "y")
    model <- try(nls(y ~ maxInfo * exp(-decayRate * x) + NbodyInfo, start=list(maxInfo=y[1], decayRate=1, NbodyInfo=y[length(y)]), data=data))
    if (class(model) != "try-error") {
        output <- c(y[1], y[length(y)], 1/coef(model)[2], y[length(y)]/y[1])
        names(output) <- c("Average 1-body Total Intercorrelation", paste("Average ", length(i), "-body Total Intercorrelation", sep=""), "Mean Lifetime", paste("Fraction ", length(i), "-body Total Intercorrelation", sep =""))
        newdata <- list(2:length(i) - 2)
        names(newdata) <- c("x")
        output
    } else {
        print("Data does not fit exponential decay. Check for multiple rigid bodies or a completely disordered systems.")
        y
    }
}


calculate.average.rigid.body.inter <- function(C, i, atom) {
    ave.results <- function(i) {
        apply(i, 2, mean)
    }
    results <- lapply(C, rigid.body.characteristics.total.intercorrelation.2, i=i, atom=atom)
    new_results <- NULL
    for (j in 1:length(C)) {
        new_results <- rbind(new_results, results[[j]])
    }
    mean_results <- apply(new_results, 2, mean)
    sd_results <- apply(new_results, 2, sd)
    list(mean_results, sd_results)
}

calculate.average.rigid.body <- function(C, i, atom) {
    ave.results <- function(i) {
        apply(i, 2, mean)
    }
    results <- lapply(C, rigid.body.characteristics.2, i=i, atom=atom)
    new_results <- results[[1]]
    for (j in 2:length(C)) {                
        new_results <- rbind(new_results, results[[j]])
    }       
    mean_results <- apply(new_results, 2, mean)        
    sd_results <- apply(new_results, 2, sd)
    list(mean_results, sd_results)
}

total.intercorrelation.coefficient <- function(C, i, j, atom) {
    ij <- intersect(i,j)
    i <- setdiff(i, ij)
    j <- setdiff(j, ij)
    sqrt(1 - exp(-2*total.intercorrelation(C, i, j, atom)/(3*sum(atom[c(i,j)]) - 1)))
}

calculate.average.intercorrelation.coefficient <- function(C, i, j, atom) {
    output_mean <- mean(unlist(lapply(C, total.intercorrelation.coefficient, i=i, j=j, atom=atom)))
    output_sd <- sd(unlist(lapply(C, total.intercorrelation.coefficient, i=i, j=j, atom=atom)))
    list(output_mean, output_sd)
}

calculate.all.frc.average.intercorrelation.coefficient <- function(C, FRC, atom) {
    output <- list(matrix(ncol = length(FRC), nrow = length(FRC), 1),matrix(ncol = length(FRC), nrow = length(FRC), 0))
    for (i in 1:length(FRC)) {
        for (j in 1:length(FRC)) {
            if (i < j) {
                tmp <- calculate.average.intercorrelation.coefficient(C, FRC[[i]], FRC[[j]], atom)
                output[[1]][i,j] <- tmp[[1]]
                output[[1]][j,i] <- tmp[[1]]
                output[[2]][i,j] <- tmp[[2]]
                output[[2]][j,i] <- tmp[[2]]
            }
        }
    }
    output
}

all.equal <- function(x, y) {
    if (length(x) == length(y)) {
        all(x == y)
    } else {
        !isTRUE(TRUE)
    }
}

which.list <- function(L, i) {
    which(unlist(lapply(L, all.equal, i)))
}
