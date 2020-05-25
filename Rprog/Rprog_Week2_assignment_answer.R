
# pollutantmean() ---------------------------------------------------------

# pollutantmean() calculates the mean of a pollutant (sulfate or nitrate)
# across a specified list of monitors (csv files)
pollutantmean <- function(directory="./specdata", pollutant="sulfate", id=1:332){
        filePath <- list.files(path = directory, pattern = "\\.csv$", full.names = T)
        
        p <- pollutant
        n <- vector()
        for (i in id){
                f <- read.csv(filePath[i])
                v <- f[!is.na(f[p]), ][, p]
                n <- c(n, v)
        }
        mean(n)
}


# complete() --------------------------------------------------------------

# complete() reports the number of completely observed cases in each csv files
complete <- function(directory="./specdata", id=1:332){
        filePath <- list.files(path = directory, pattern = "\\.csv$", full.names = TRUE)
        t <- data.frame(id=numeric(), nobs=numeric())
        for (i in id){
                f <- read.csv(filePath[i])
                n <- dim(f[complete.cases(f),])[1]
                t[nrow(t)+1, ] <- list(i, n)
        }
        t
}



# corr() ------------------------------------------------------------------

# corr() set a threshold for complete cases, and calculates the correlation 
# between sulfate and nitrate for monitor locations where the number of completely
# observed cases (on all variables) is greater than the threshold
corr <- function(directory="./specdata", threshold=0){
        filePath <- list.files(path = directory, full.names = TRUE)
        co <- vector()
        for (i in filePath){
                f <- read.csv(i)
                n <- dim(f[complete.cases(f),])[1]
                if (n > threshold){
                        c <- cor(f[complete.cases(f), ]$sulfate, f[complete.cases(f),]$nitrate)
                        co <- c(co, c)
                }
        }
        co
}
