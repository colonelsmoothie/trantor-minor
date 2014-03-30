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
claimsize <- 5000
freq <- .08
prem <- claimsize * freq

### Connect to the MySQL Server

library(RMySQL)

### We need to grant access to 'someuser' using the DB management system
con <- dbConnect(MySQL(), user="someuser",dbname = "proto_minor_0")

dbGetQuery(con, "DROP TABLE IF EXISTS Policy;")

dbGetQuery(con, "CREATE TABLE Policy (
                 Policy_ID BIGINT NOT NULL,
                 FirstName VARCHAR(255) NOT NULL,
                 LastName VARCHAR(255) NOT NULL,
                 Incept_Date DATE NOT NULL,
                 Exp_Date DATE NOT NULL,
                 GrossWrittenPremium DOUBLE NOT NULL,
                 PRIMARY KEY (Policy_ID));")

### Check to see if table was created properly

dbGetQuery(con, "DESC Policy;")

### Generate policy table

Policy_ID <- 1:polcount
set.seed(52)
Names <- generate_names(polcount,firstnames,lastnames)
### check names
head(Names)

set.seed(97)
Dates <- generate_dates(polcount,"2000-01-01","2003-01-01")
head(Dates)

GrossWrittenPremium <- rep(5000,prem)

Policy <- cbind(Policy_ID,Names,Dates,GrossWrittenPremium)
head(Policy)

### Generate claim table

dbGetQuery(con, "DROP TABLE IF EXISTS Claim;")

dbGetQuery(con, "CREATE TABLE Claim (
                 Claim_ID BIGINT NOT NULL,
                 Claim_Date DATE NOT NULL,
                 Policy_ID BIGINT NOT NULL,
                 Incurred DOUBLE NOT NULL,
                 PRIMARY KEY (Claim_ID),
                 FOREIGN KEY (Policy_ID) REFERENCES Policy(Policy_ID));")

dbGetQuery(con, "DESC Claim;")

set.seed(9632)
Claim <- data.frame(Claim_Date=character(),Policy_ID=as.numeric(c()))
names(Claim) <- c("Claim_Date","Policy_ID")
class(Claim[,"Claim_Date"]) <- "Date"
Claimrow <- 1
for(i in 1:polcount){
  claimcount <- 0
  claimcount <- rpois(1,freq)
  if(claimcount > 0){
    for(j in 1:claimcount){
      claim_date <- runif(1,as.numeric(Policy[i,"Incept_Date"]),as.numeric(Policy[i,"Exp_Date"]))
      class(claim_date) <- 'Date'
      Claim[Claimrow,1] <- claim_date
      Claim[Claimrow,2] <- i
      Claimrow <- Claimrow + 1
    }
  }
}
Claim <- Claim[order(Claim$Claim_Date),]
Incurreds <- rep(claimsize,nrow(Claim))
Claim <- cbind(Claim_ID=1:nrow(Claim),Claim,Incurred=Incurreds)
head(Claim)


dbWriteTable(con, "Policy", Policy, append=TRUE, row.names=FALSE)
dbWriteTable(con, "Claim", Claim, append=TRUE, row.names=FALSE)