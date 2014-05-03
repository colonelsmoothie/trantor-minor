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
    pay.period <- pollen/n.interval
    pay.dates <- seq(as.numeric(Policy[i,"Incept_Date"],as.numeric(Policy[i,"Exp_Date"]),n.interval))
    payment.amt <- Policy[i,"GrossWrittenPremium"] / n.interval
    prem.transacts <- cbind(i,pay.dates,payment.amt)
  }
  ###
  ### Table should contain all premium transactions for all policies
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  return(Premium_Transaction)
}