### Takes Policy data frame as input and generates premium transactions using the policy dates
### Arguments:
### Policy - the policy data frame
### interval - payment interval (monthly, weekly, etc.)

gen_prem_transact <- function(Policy,n.interval=12){
  polcount <- nrow(Policy)
  for(i in 1:polcount){
    pollen <- as.numeric(Policy[i,"Exp_Date"] - Policy[i,"Incept_Date"])
    pay.period <- pollen/n.interval
    pay.dates <- seq(as.numeric(Policy[i,"Incept_Date"],as.numeric(Policy[i,"Exp_Date"]),n.interval))
    payment.amt <- Policy[i,"GrossWrittenPremium"] / n.interval
  }
  
}