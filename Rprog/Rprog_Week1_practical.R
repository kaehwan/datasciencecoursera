pacman::p_load(pacman, tidyverse)

# R console input and evaluation ------------------------------------------

(x <- 1)
# the [1] indicates that x is a vector and 1 is the first element

(y <- 1:20)
# The : operator is used to create integer sequences


# Data Types - R objects and attributes -----------------------------------

# Everthing in R is an object, just like Python
# character, numeric, integer, complex, logical
# Most basic object is a vector. To create empty vector, use vector()
# "NaN" not a number
# R object can have attributes: names, dimnames, dimensions, class, length, other user-defined attributes/metadatas
# use attributes() function to access attributes of an object


# Data Types - Vectors and lists ------------------------------------------

(x <- vector("numeric", length=10))

# when diff. objects are mixed in a vector, coercion occurs so that each element in vector is of the same class

# change the class of x
(x <- 0:6)
as.numeric(x)
as.logical(x)
as.character(x)

# explicit coercion results in NAs.
(y <- c("a", "b", "c"))
as.numeric(y)
as.logical(y)
as.integer(y)

# Lists are a special type of vector that can contain elements of different classes

# Data Types - Matrices ---------------------------------------------------

# Matrices are vectors with a dimension attribute
# The dimension attribute is itself an integer vector of length 2 (nrow, ncol)

# Matrices are column-wise
(m <- matrix(1:6, nrow = 2, ncol = 3))

# To create matrix, can use column-binding or row-binding
x <- 1:3
y <- 10:12
(cbind(x,y))
(rbind(x,y))

# Data Types - Factors ----------------------------------------------------

# Factors are used to represent categorical data
# factors can be unordered or ordered
# factors can be created with factor()
(x <- factor(c("yes", "no", "no", "no", "yes")))
attributes(x)
table(x)
unclass(x)

# The order of the levels can be set using the levels argument to factor()
(x <- factor(c("yes", "no", "no", "no", "yes"), levels = c("yes", "no")))

# Date Types - Missing values ---------------------------------------------

# NA or NaN
# is.na() to test if they are NA
# is.nan() to test for NaN
# NaN is NA, but NA is not NaN

# Data Types - Data frames ------------------------------------------------

# used to store tabular data
# DF has a special attributes called row.names()
# DF can be created by read.table() or read.csv()
# covert to a matrix, use data.matrix()

# Data Types - Names attribute --------------------------------------------

# R objects can have names
(x <- c(1,2,3))
(names(x) <- c("a", "b", "c"))
x
# list and matrix can have names too. for matrix, use dimnames() function

# Data Types - Summary ----------------------------------------------------


# Reading tabular data ----------------------------------------------------

# read.table, read.csv() for reading tabular data
# readLines for reading lines of a text file

# write.table, writeLines

# read.table: file, header, sep, colClasses, nrows, comment.char, skip, stringsAsFactors

# Reading large tables ----------------------------------------------------

# set comment.char="" if there are no commented lines in your file to speed up reading 
# read some rows to figure out the colClasses, the apply it back to read the whole datasets will be faster
init <- read.table("dataset.txt", nrows = 100)
classes <- sapply(init, class)
tabAll <- read.table("dataset.txt", colClasses = classes)

# Textual data formats ----------------------------------------------------

# dumping and dputting preserve the metadata
# dput() used for single R object
(y <- data.frame(a = 1, b = "a"))
(dput(y, file="y.R"))
(new.y <- dget("y.R"))
# dumpt() can be used for multiple R objects and read back using source()
(x <- "foo")
(y <- data.frame(a = 1, b = "a"))
(dump(c("x", "y"), file = "data.R"))
rm(x, y)
source("data.R")

# Connections: Interfaces to the outside world ----------------------------

# file, opens a connection to a file
# gzfile, to a file compressed with gzip
# bzfile, ... bzip2
# url, opens a connection to a webpage
str(file)

con <- file("foo.txt", "r")
data <- read.csv(con)
close(con)
# same as...
data <- read.csv("foo.txt")

# Subsetting - Basics -----------------------------------------------------

# [ returns an object of the same class as origin
# [[ to extract elements of a list or DF
# $ to extract elements of a list or DF by name
# logical indexing is applicable
(x <- c("a", "b", "B", "C", "d"))
x[x>"a"]

# Subsetting - Lists ------------------------------------------------------

(x <- list(foo = 1:4, bar = 0.6, baz = "hello"))
x[1]  # to subset object 1
x[[1]]  # to subset elements of object 1
x$bar
x["bar"]
x[c(1, 3)]  # subset two objects with vector

# Subsetting nested elements of a list
(x <- list(a=list(10, 11, 12), b=c(3.14, 2.81)))
x[[c(1, 3)]]  # subset third elements of list from 1st element (a) of x list
x[[1]][[3]]  # first subset 1st element of x, then continue subset 3rd of list a
x[[c(2, 1)]]

# Subsetting - Matrix -----------------------------------------------------

(x <- matrix(1:6, 2, 3))
x[1, 3]  # subset
x[1, ]  # subset whole row
x[1, ,drop=FALSE]  # subsetting a single col or row will give a vector, use drop=FALSE to return a matrix

airquality %>%
  filter(Ozone>31, Solar.R>91)

# Subsetting - Partial matching -------------------------------------------

# partial matching of names is allowed with [[ and $
(x <- list(asdf = 1:5))
x$a
x[["a", exact=FALSE]]

# Subsetting - Removing missing values ------------------------------------

# remove NA values
(x <- c(1, 2, NA, 4, NA, 5))
bad <- is.na(x)
x[!bad]

airquality[1:6, ]  # subset first six rows of airquality dataset
good <- complete.cases(airquality)
airquality[good, ][1:6, ]  # firstly, subset all non-NA rows, secondary, subset the first 6 rows

# Vectorized operations ---------------------------------------------------

# many operations (=-*/) in R are vectorized
x <- 1:4; y <- 6:9
x + y
x - y
x >= 2

# element-wise operations in matrices
(x <- matrix(1:4, 2, 2)); (y <- matrix(rep(10, 4), 2, 2))  # create a y matrix with replicated 10, 2 x 2 
x * y
