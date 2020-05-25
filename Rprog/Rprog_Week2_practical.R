
# if-else -------------------------------------------------------
x <- 10

if (x < 3){
  y <- 10
} else if (x > 3) {
  y <- 100
} else {
  y <- 0
}



# for loop ------------------------------------------------------

for (i in 1:10) {
  print(i)
}

# for loop for vector
x <- c("a", "b", "c", "d", "e")

for (i in 1:5) {
  print(x[i])
}

for (letter in x) {
  print(letter)
}

# for loop for matrix
y <- matrix(1:6, 2, 3)
for (i in seq_len(nrow(y))){
  for (j in seq_len(ncol(y))){
    print(y[i, j])
  }
}

# while loop ----------------------------------------------------

# will execute as long as the (condition==TRUE)
count <- 0

while (count < 10) {
  print(count)
  count <- count + 1
}

# write a while loop for binomial test of flipping coin

z <- 6

while (z >= 3 && z <=10){
  print(z)
  coin <- rbinom(1, 1, 0.5)
  if (coin == 1){
    z <- z + 1
  } else {
    z <- z - 1
  }
}

# repeat --------------------------------------------------------

# repeat initiates an infinite loop (it can be dangerous)
# the only way to exit repeat is to call break

x0 <- 1
tot <- 1e-8
repeat {
  x1 <- somefunction()
  if (abs(x1 - x0) <= tot){
    break
  } else {
    x0 <- x1
  }
}


# next ----------------------------------------------------------

# next is used to skip an iteration of a loop
for (i in 1:100){
  if (i <= 20){
    next
  } else {
    print(i)
  }
}

# return --------------------------------------------------------

# return signals that a function should exit and return a given value

# function ------------------------------------------------------

add2 <- function(x, y){
  x + y
}

# create a function to quan column mean of dataframe
cmean <- function(y, removeNA = TRUE){
  nc <- ncol(y)
  means <- numeric(nc)  # this line creates an empty vector with nc elecments
  for (i in 1:nc){
    means[i] <- mean(y[ , i], na.rm = removeNA)
  }
  return(means)
}

# Scoping rules...
# Lexical scoping...

# Date and times ------------------------------------------------

x <- as.Date("2000-09-28")
x
unclass(as.Date(x))  # count the number of days from 1970-01-01

y <- Sys.time()
y
p <- as.POSIXlt(y)  # as.POSIXlt gives a list underneath the date from 1970-01-01
names(unclass(p))
p$year

# strptime() function for datetimes written in different format
my_datetime <- c("Jan 10, 2010 23:12", "Apr 29, 2020 07:20")
(my_datetime <- strptime(my_datetime, "%B %d, %Y %H:%M"))

bday <- c("Sep 28, 1988 15:00")
(bday <- strptime(bday, "%B %d, %Y %H:%M"))
as.POSIXlt(new_bday) - as.POSIXlt(new_data)
