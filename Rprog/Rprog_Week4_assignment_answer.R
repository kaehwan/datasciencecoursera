getwd()
setwd("~/R/Data_science_coursera/Assignment3/")

(outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character"))
head(outcome)  # show the first few rows
ncol(outcome)  # no. of columns
names(outcome) # to set or get the names of object

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])


best <- function(state, outcome){
        ## Read outcome data
        my_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        all_states <- unique(my_data$State)
        all_outcome <- c("heart attack", "heart failure", "pneumonia")
        if (state %in% all_states){
                if (tolower(outcome) %in% all_outcome){
                        my_data[, 11] <- suppressWarnings(as.numeric(my_data[, 11]))
                        my_data[, 17] <- suppressWarnings(as.numeric(my_data[, 17]))
                        my_data[, 23] <- suppressWarnings(as.numeric(my_data[, 23]))
                        my_data <- my_data[my_data$State == state, ]
                        hospital <- vector()
                        if (tolower(outcome)=="heart attack"){
                                min_value <- min(my_data[, 11], na.rm = T)
                                index <- which(my_data[, 11]==min_value)
                        } else if (tolower(outcome)=="heart failure"){
                                min_value <- min(my_data[, 17], na.rm = T)
                                index <- which(my_data[, 17]==min_value)
                        } else if (tolower(outcome)=="pneumonia"){
                                min_value <- min(my_data[, 23], na.rm = T)
                                index <- which(my_data[, 23]==min_value)
                        }
                        for (i in index){
                                hospital <- c(hospital, my_data[i, "Hospital.Name"])
                        }
                        print(sort(hospital)[1])
                        
                } else {stop("invalid outcome")}
                
        } else {stop("invalid state")}
        
}


rankhospital<- function(state, outcome, num = "best")
{
        outcome1 <- read.csv("outcome-of-care-measures.csv",
                             colClasses = "character")
        if(!any(state == outcome1$State)){
                stop("invalid state")}
        else if((outcome %in% c("heart attack", "heart failure",
                                "pneumonia")) == FALSE) {
                stop(print("invalid outcome"))
        }
        outcome2 <- subset(outcome1, State == state)
        if (outcome == "heart attack") {
                colnum <- 11
        }
        else if (outcome == "heart failure") {
                colnum <- 17
        }
        else {
                colnum <- 23
        }
        outcome2[ ,colnum] <- suppressWarnings(as.numeric(outcome2[ ,colnum]))
        outcome3 <- outcome2[order(outcome2[ ,colnum],outcome2[,2]), ]
        outcome3 <- outcome3[(!is.na(outcome3[ ,colnum])),]
        if(num == "best"){
                num <- 1
        }            
        else if (num == "worst"){
                num <- nrow(outcome3)
        }      
        return(outcome3[num,2])
}


rankall <- function(outcome, num = "best") {
        ## Read outcome data: COLS: HospitalName, State, HeartAttack, HearFailure, Pneumonia
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")[,c(2,7,11,17,23)]
        
        ## Check that state and outcome are valid  
        if(! (outcome == "heart attack" || outcome == "heart failure" || outcome == "pneumonia") ) {
                stop("invalid outcome")
        }
        
        if(class(num) == "character"){
                if (! (num == "best" || num == "worst")){
                        stop("invalid number")
                }
        }
        
        ## For each state, find the hospital of the given rank
        ## Return a data frame with the hospital names and the (abbreviated) state name
        
        # Remove columns by outcome, only left HospitalName and Deaths by outcome
        if(outcome == "heart attack") {
                data = data[,c(1,2,3)]
        } else if(outcome == "heart failure") {
                data = data[,c(1,2,4)]
        } else if(outcome == "pneumonia") {
                data = data[,c(1,2,5)]
        }
        names(data)[3] = "Deaths"
        data[, 3] = suppressWarnings( as.numeric(data[, 3]) )
        
        # Remove rows with NA
        data = data[!is.na(data$Deaths),]
        
        splited = split(data, data$State)
        ans = lapply(splited, function(x, num) {
                # Order by Deaths and then HospitalName
                x = x[order(x$Deaths, x$Hospital.Name),]
                
                # Return
                if(class(num) == "character") {
                        if(num == "best") {
                                return (x$Hospital.Name[1])
                        }
                        else if(num == "worst") {
                                return (x$Hospital.Name[nrow(x)])
                        }
                }
                else {
                        return (x$Hospital.Name[num])
                }
        }, num)
        
        #Return data.frame with format
        return ( data.frame(hospital=unlist(ans), state=names(ans)) )
        
}


best2 <- function(state, outcome)
{
        # load necessary libraries
        pacman::p_load(pacman, tidyverse)
        # read the csv file
        df <- read.csv("outcome-of-care-measures.csv", colClasses="character")
        all.states  <- unique(df$State)
        # convert state to uppercase and outcome to lower case
        state   <- toupper(state)
        outcome <- tolower(outcome)
        # check if the state and outcome given are correct
        if ((state %in% all.states)==FALSE){stop("invalid state")}
        else if ((outcome %in% c("heart attack", "heart failure", "pneumonia"))==FALSE){stop("invalid outcome")}
        # subset new dataframe for easier handling of data with appropriate column names
        cname <- c("hospitals", "states", "heart attack", "heart failure", "pneumonia")
        newdf <- df[c(2, 7, 11, 17, 23)]
        colnames(newdf) <- cname
        # subset using the state to create new dataframe with hospital and related outcome
        newdf <- subset(newdf, states==state, select=c("hospitals", outcome))
        # coerce the class of outcome (character) to numeric
        newdf[, outcome] <- suppressWarnings(as.numeric(newdf[, outcome]))
        # find rows which contains the minimum death rates (with NA removed)
        min_rows <- which(newdf[, outcome]==min(newdf[, outcome], na.rm=T))
        # find all the hospitals with minimum death rates and sort the hospitals
        hospitals <- newdf[min_rows, 1]
        hospitals <- sort(hospitals)
        # return the first element of hospitals
        return(hospitals[1])
        
}


rankhospital2 <- function(state, outcome, num="best")
{
        pacman::p_load(pacman, tidyverse)
        
        df <- read.csv("outcome-of-care-measures.csv", colClasses="character")
        all.states <- df$State
        state <- toupper(state)
        outcome <- tolower(outcome)
        if ((state %in% all.states)==F){stop("invalid state")}
        if ((outcome %in% c("heart attack", "heart failure", "pneumonia"))==F){stop("invalid outcome")}
        
        newdf1 <- df[c(2,7,11,17,23)]
        colNames <- c("hospitals", "states", "heart attack", "heart failure", "pneumonia")
        colnames(newdf1) <- colNames
        newdf2 <- subset(newdf1, states==state, select=c("hospitals", outcome))
        newdf2[, outcome] <- suppressWarnings(as.numeric(newdf2[, outcome]))
        newdf3 <- newdf2[order(newdf2[, outcome], newdf2[, "hospitals"]), ]
        newdf3 <- newdf3[(!is.na(newdf3[, outcome])), ]
        
        if (is.character(num)){
                if (num=="best"){num=1} 
                else if (num=="worst"){num=nrow(newdf3)}
                else {stop("invalid number")}
        } else if (is.numeric(num)){
                if (num>nrow(newdf3)){return("<NA>")}
                else {num=num}
        }
        return(newdf3[num, "hospitals"])
        
}


rankall2 <- function(outcome, num="best")
{
        pacman::p_load(pacman, tidyverse)
        df <- read.csv("outcome-of-care-measures.csv", colClasses="character")
        outcome <- tolower(outcome)
        outcomes <- c("heart attack", "heart failure", "pneumonia")
        if((outcome %in% outcomes)==F){stop("invalid outcome")}
        
        df <- df[c(2,7,11,17,23)]
        colnames(df) <- c("hospitals", "states", "heart attack", "heart failure", "pneumonia")
        df[outcomes] <- sapply(df[outcomes], as.numeric)
        df <- subset(df, select = c("hospitals", "states", outcome))
        df <- df[!is.na(df[, outcome]), ]
        df <- df[order(df[, outcome], df$hospitals), ]
        
        splited <- split(df, df$states)
        a <- lapply(splited, function(x, num){
                if (is.character(num)){
                        if (num=="best"){
                                return(x$hospitals[1])
                        } else if (num=="worst"){
                                return(x$hospitals[nrow(x)])
                        } else {stop("invalid num")}
                } else if (is.numeric(num)){
                        return(x$hospitals[num])
                }
        }, num)
        
        # return data.frame with format
        return(data.frame(hospital=unlist(a), state=names(a)))

}
