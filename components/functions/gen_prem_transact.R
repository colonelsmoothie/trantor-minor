### Takes Policy data frame as input and generates premium transactions using the policy dates
### Arguments:
### Policy - the policy data frame
### interval - payment interval (monthly, weekly, etc.)

gen_prem_transact <- function(Policy,interval=12){
  polcount <- nrow(Policy)
  for(i in 1:polcount){
    pollen <- Policy[i,"Exp_Date"] - Policy[i,"Incept_Date"]
    n.payments <- pollen/interval
  }
  
}