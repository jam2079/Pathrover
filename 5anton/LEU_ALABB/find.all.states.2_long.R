asp <- read.table("asp_data_long.txt")
glu <- read.table("glu_data_long.txt")
phe <- read.table("phe_data_long.txt")
arg <- read.table("arg_data_long.txt")

angle.between.points <- function(x1, x2, y1, y2) {
	2*atan((x2 - x1)/(y2 - y1))*180/pi
}

get.fit <- function(x, x_fit, x_raw) {
                mean(x_raw[which(x_fit==x)])
}

angle.sd <- function(x) {
	r <- (x + 180)*pi/180
	cs <- cbind(cos(r), sin(r))
	a <- matrix(ncol=1, nrow=nrow(cs), 0)
	for (i in 1:nrow(cs)) {
		a[i] <- angle.between.points(cs[i,1], cs[i,2], mean(cs[,1]), mean(cs[,2]))
	}
	sd(a)
}

find.states <- function(data) {
	r <- (data + 180)*pi/180
	k <- 1
	km <- kmeans(cbind(cos(r), sin(r)), 2)
        states <- km$centers 	
	output <- km$cluster
	if (abs(angle.between.points(states[1,1], states[1,2], states[2,1], states[2,2])) < 90) {
		output <- matrix(ncol=1, nrow=length(data), 1)
	}
	output
}

determine.state <- function(data) {
	state <- matrix(ncol = ncol(data), nrow = nrow(data))
	for (i in 1:ncol(data)) {
		state[,i] <- find.states(data[,i])
	}
	state
}

write.table(determine.state(asp), file="asp_symmetry_long.txt", row.names=FALSE, col.names=FALSE)
write.table(determine.state(glu), file="glu_symmetry_long.txt", row.names=FALSE, col.names=FALSE)
write.table(determine.state(arg), file="arg_symmetry_long.txt", row.names=FALSE, col.names=FALSE)
write.table(determine.state(phe), file="phe_symmetry_long.txt", row.names=FALSE, col.names=FALSE)
q()
