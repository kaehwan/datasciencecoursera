
# str() -------------------------------------------------------------------

# compactly display the internal structure of an R object
# a diagnostic function and an alternate to summary()
str(str)

# Simulation - Generating random numbers ----------------------------------

# rnorm, dnorm, pnorm, rpois
# rnorm: generate random normal variates with a given mean and sd
# dnorm: evaluate the normal probability density (with a given mean/sd) at a point (or vector of point)
# pnorm: evaluate the cumulative distribution function for a normal distribution
# rpois: generate random Poisson variates with a given rate
# d for density
# r for random number generation
# p for cumulative distribution
# q for quantile function

# set.seed() ensures reproducibility


# Simulation - Simulating a linear model ----------------------------------

# Example of simulating a linear model:
# y = a + bx + e
# where e ~ N(0, 2^2), assume x ~ N(0, 1^2), a = 0.5, b = 2
set.seed(1)
x <- rnorm(100, 0, 1)
e <- rnorm(100, 0, 2)
a <- 0.5
b <- 2
y <- a + b*x + e
summary(y)
plot(x, y)  # plot() is scatter plot

# if x is a binary (zero or one)?
x <- rbinom(100, 1, 0.5)  # e.g. flipping a coin
y <- a + b*x + e
plot(x, y)

# simulate from a Poisson model where
# y ~ Poisson(u)
# log(u) = a + bx
# and a = 0.5, b = 0.3. We need to use rpois()
set.seed(1)
x <- rnorm(100, 0, 1)
log.mu <- 0.5 + 0.3*x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)


# Simulation - Random sampling --------------------------------------------

# sample() draw randomly from a specified set of scalar objects allowing you to sample from arbitrary distributions
sample(1:10, 4)
sample(letters, 5)
sample(1:10)  # permutation

# R profiler --------------------------------------------------------------

# system.time() returns the amount of time taken to evaluate the expression
# can wrap the whole things in curly braces for execution of system.time()
system.time({
        n <- 1000
        r <- numeric(n)
        for (i in 1:n){
                x <- rnorm(n)
                r[i] <- mean(x)
        }
})

# Rprof() starts the profiler in R, run the profiler for performance of analysis of R code
# Rprof() keeps track of the function call stack at regularly sampled intervals and tabulates how much time is spend in each function
# summaryRprof() summarizes the output from Rprof()
# summaryRprof() tabulates the R profiler output and calculates how much time is spent in which function

