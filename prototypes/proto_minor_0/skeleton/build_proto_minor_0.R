# not sure if I need this line
setwd("./github/trantor-minor")

### Import dataset
### Import names from name files
firstnames <- as.matrix(read.csv("./components/names/CSV_Database_of_First_Names.csv", header=TRUE))
lastnames <-as.matrix(read.csv("./components/names/CSV_Database_of_Last_Names.csv", header=TRUE))


### Source scripts that contain functions
### We'll need these to build the tables
source("./components/functions/generate_dates.R")
source("./components/functions/generate_names.R")


### Specify db parameters here
polcount <- 50000


### Connect to the MySQL Server

library(RMySQL)

### We need to grant access to 'someuser' using the DB management system
con <- dbConnect(MySQL(), user="someuser",dbname = "proto_minor_0")

dbGetQuery(con, "CREATE TABLE IF NOT EXISTS Policy (
                 Policy_ID BIGINT NOT NULL,
                 FirstName VARCHAR(255) NOT NULL,
                 LastName VARCHAR(255) NOT NULL,
                 Incept_Date DATE NOT NULL,
                 Exp_Date DATE NOT NULL,
                 PRIMARY KEY (Policy_ID));")

### Check to see if table was created properly

dbGetQuery(con, "DESC Policy;")

### Generate policy table



### Generate claim table