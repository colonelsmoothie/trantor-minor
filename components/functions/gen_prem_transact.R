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
Policy
i <- 1
n.interval = 12
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
prem.transacts <- cbind(i,pay.dates,payment.amt)
prem.transacts
##
