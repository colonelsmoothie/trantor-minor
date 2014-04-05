### takes a data frame containing policy information and uses that to generate claims table

generate_claims <- function(policytable, freq){
  polcount <- nrow(policytable)
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
  return(Claim)
}