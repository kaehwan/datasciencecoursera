
# Looping on the command line ---------------------------------------------

# lapply: loop over a list and evaluate a function on each element
# sapply: same as lapply but try to simplify the result
# apply : apply a function over the margins of an array
# tapply: apply a function over subsets of vector
# mapply: multivariate version of lapply

# lapply takes 3 arguments: a list, a function and ... argument
# lapply always return a list
x <- list(a=1:20, b=rnorm(20), c=rnorm(20,1), d=rnorm(100,5))
lapply(x, mean)
sapply(x, mean)  # return a vector (or matrix) instead of a list

# lapply and friends make heavy use of anonymous functions
x <- list(a=matrix(1:4, 2, 2), b=matrix(1:9, 3,3))
lapply(x, function(abc) abc[, 1])  # an anonymous function for extracting first column of each matrix

# apply is most often used to apply a function to the rows or columns of a matrix
# apply takes 4 arguments: array, margin, function, ...
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)  # calculate the mean of columns
apply(x, 1, sum)  # calculate the mean of rows
# rowSums = apply(x, 1, sum)
# rowMeans = apply(x, 1, mean)
# colSums = apply(x, 2, sum)
# colMeans = apply(x, 2, mean)

# Average matrix in an array
(x <- array(rnorm(2*2*10), c(2, 2, 10)))
apply(x, c(1, 2), mean)

# mapply is a multivariate apply of sorts which applies a function in parallel over a set of arguments
str(mapply)
# function(FUN, ..., MoreArgs=NULL, SIMPLIFY=T, USE.NAMES=T)
# mapply example 1
list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))  # this is tedious to type
mapply(rep, 1:4, 4:1)  # we can do this instead

# mapply example 2
noise <- function(n, mean, sd){
        rnorm(n, mean, sd)
}
list(noise(1,1,2), noise(2,2,2),
     noise(3,3,2), noise(4,4,2),
     noise(5,5,2))  # this is tedious typing
mapply(noise, 1:5, 1:5, 2)

# tapply is used to apply a function over subsets of a vector
str(tapply)
# function(X, INDEX, FUN=NULL, ..., default=NA, simplify=TRUE)
# tapply example 1: take group means
(x <- c(rnorm(10), runif(10), rnorm(10, 1)))
(f <- gl(3, 10))
tapply(x, f, mean)
tapply(x, f, mean, simplify = F)
# tapply example 2: find group ranges
tapply(x, f, range)

# split() takes a vector or other objects and splits it into groups determined by a factor or list of factors
str(split)
# function(x, f, drop=FALSE, ...)
# x is a vector (or list) or dataframe. f is a factor. drop indicates if empty factors levels should be dropped
# split example 1:
split(x, f)
# split example 2: use lapply with split
lapply(split(x, f), mean)
# split example 3: split data frame
(s <- split(airquality, airquality$Month))
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T))
# split on more than one level
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f <- interaction(f1, f2)
str(split(x, f))  # interactions can create empty levels
str(split(x, list(f1, f2), drop=T))  # same as above, drop=TRUE to drop empty levels

