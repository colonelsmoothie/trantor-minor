### import names from name files
firstnames <- as.matrix(read.csv("./github/trantor-minor/components/names/CSV_Database_of_First_Names.csv", header=TRUE))
lastnames <-as.matrix(read.csv("./github/trantor-minor/components/names/CSV_Database_of_Last_Names.csv", header=TRUE))

### generate policy holder names by sampling from first and last name vectors
set.seed(42)
first <- sample(firstnames,20,replace=TRUE)
last <- sample(lastnames, 20, replace=TRUE)

policyholder <- cbind(first, last)
policyholder

test <- generate_names(50,fseq=firstnames,lseq=lastnames)

### Using the generate_names function

### import the generate_names function

source("./github/trantor-minor/components/functions/generate_names.R")

### This example generates a data frame of 50 first and last names, each row represents a person
set.seed(43)
policyholder <- generate_names(50,fseq=firstnames,lseq=lastnames)
policyholder
