### import names from name files
firstnames <- as.matrix(read.csv("./github/trantor-minor/components/names/CSV_Database_of_First_Names.csv", header=TRUE))
lastnames <-as.matrix(read.csv("./github/trantor-minor/components/names/CSV_Database_of_Last_Names.csv", header=TRUE))

### generate policy holder names by sampling from first and last name vectors
set.seed(42)
first <- sample(firstnames,20,replace=TRUE)
last <- sample(lastnames, 20, replace=TRUE)

policyholder <- cbind(first, last)
policyholder
