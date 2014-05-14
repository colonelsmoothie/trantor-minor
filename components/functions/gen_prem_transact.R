### Takes Policy data frame as input and generates premium transactions using the policy dates
### Arguments:
### Policy - the policy data frame
### interval - payment interval (monthly, weekly, etc.)


### initialize variables for testing - delete later


### might want to check out if GWP is necessary in the other table, maybe make a distinction between OGWP and GWP actually realised

gen_prem_transact <- function(Policy,n.interval=12){
  polcount <- nrow(Policy)
  for(i in 1:polcount){
    pollen <- as.numeric(Policy[i,"Exp_Date"] - Policy[i,"Incept_Date"])
    ### calculate length of each interval
    #pay.period <- pollen/n.interval
    pay.dates <- seq(as.numeric(Policy[i,"Incept_Date"]),as.numeric(Policy[i,"Exp_Date"]),length.out=n.interval)
    payment.amt <- Policy[i,"GrossWrittenPremium"] / n.interval
    prem.transacts <- cbind(i,pay.dates,payment.amt)
  }
  
  #
  return(Premium_Transaction)
}


### Unencapsulated code for testing

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
polcount <- 5
claimsize <- 5000
freq <- .08
prem <- claimsize * freq

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

#### test table
Policy
i <- 1
n.interval = 12
curr.transact <- 1
pollen <- as.numeric(Policy[i,"Exp_Date"] - Policy[i,"Incept_Date"])
pollen
### calculate length of each interval
pay.period <- pollen/n.interval
pay.period
pay.dates <- seq(from=as.numeric(Policy[i,"Incept_Date"]),to=as.numeric(Policy[i,"Exp_Date"]), length.out=n.interval)
class(pay.dates) <- 'Date'
pay.dates
### check to see if incept date same as first payment date
Policy[i,"Incept_Date"] == min(pay.dates)
### check to see if last payment date before expiration date
Policy[i,"Exp_Date"] >= max(pay.dates)
prem.pmts <- rep(Policy[i,"GrossWrittenPremium"] / n.interval, n.interval)
prem.pmts
### check to see if sum of payments equals GWP
sum(prem.pmts) == Policy[i,"GrossWrittenPremium"]
### transact id | policy id | transaction date | payment amount
transact.ids <- seq(curr.transact, curr.transact + n.interval - 1,1)
prem.transacts <- data.frame(transact.ids,i,pay.dates,prem.pmts)
prem.transacts
### will need to change transaction order and add a tie breaker, probably by pol id
