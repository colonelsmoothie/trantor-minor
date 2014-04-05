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
source("./components/functions/generate_claims.R")


### Specify db parameters here
polcount <- 500000
claimsize <- 5000
freq <- .08
prem <- claimsize * freq

### Connect to the MySQL Server

library(RMySQL)

### We need to grant access to 'someuser' using the DB management system
con <- dbConnect(MySQL(), user="someuser",dbname = "proto_minor_0")

### Check to see if Policy and Claim tables exist, if so then delete them

dbGetQuery(con, "DROP TABLE IF EXISTS Claim;")
dbGetQuery(con, "DROP TABLE IF EXISTS Policy;")

### Create Policy and Claim tables - data generated from R will be imported into these tables in MySQL

dbGetQuery(con, "CREATE TABLE Policy (
                 Policy_ID BIGINT NOT NULL,
                 FirstName VARCHAR(255) NOT NULL,
                 LastName VARCHAR(255) NOT NULL,
                 Incept_Date DATE NOT NULL,
                 Exp_Date DATE NOT NULL,
                 GrossWrittenPremium DOUBLE NOT NULL,
                 PRIMARY KEY (Policy_ID));")

dbGetQuery(con, "CREATE TABLE Claim (
                 Claim_ID BIGINT NOT NULL,
                 Claim_Date DATE NOT NULL,
                 Policy_ID BIGINT NOT NULL,
                 Incurred DOUBLE NOT NULL,
                 PRIMARY KEY (Claim_ID),
                 FOREIGN KEY (Policy_ID) REFERENCES Policy(Policy_ID));")

### Check to see if tables were created properly

dbGetQuery(con, "DESC Policy;")
dbGetQuery(con, "DESC Claim;")

### Generate policy information

Policy_ID <- 1:polcount
set.seed(52)
Names <- generate_names(polcount,firstnames,lastnames)
### check names
head(Names)

set.seed(97)
Dates <- generate_dates(polcount,"2000-01-01","2005-01-01")
head(Dates)

GrossWrittenPremium <- rep(prem,polcount)

Policy <- cbind(Policy_ID,Names,Dates,GrossWrittenPremium)
head(Policy)

### Generate claim information
### Should probably refactor this section into a function

set.seed(9632)
Claim <- generate_claims(Policy, freq)
### Check to see if claims generation was successful
head(Claim)

### upload policy and claims information into MySQL server
dbWriteTable(con, "Policy", Policy, append=TRUE, row.names=FALSE)
dbWriteTable(con, "Claim", Claim, append=TRUE, row.names=FALSE)