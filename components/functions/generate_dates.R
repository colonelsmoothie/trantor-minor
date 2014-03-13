### function to generate policy incept and expiration dates

### Terminology
### By "policy period," we mean something like a policy year, 
### although with the constraints lbound and ubound,
### the length of the period may differ from a year

### Aguments
### n: number of policies to be generated
### lbound: day on which the policy period begins, provided as string
### ubound: day on which the policy period ends, provided as string
### idistr: distribution to be used - determines what day policy is written
### ldistr: distribution to be used - determines length of policy

library(lubridate)

static <- function(l){
  return(l)
}

generate_dates <- function(n, lbound, ubound, idistr="unif", ldistr=static(1)){
  from_date <- as.numeric(as.Date(lbound))
  to_date <- as.numeric(as.Date(ubound)) + 1
  # we use + 1 to ensure that policies written on the last date
  # can be generated
  if(idistr=="unif"){
    incept_dates <- runif(n, from_date, to_date)
  }
  class(incept_dates) <- 'Date'
  if(is.numeric(ldistr) & length(ldistr)==1){
    exp_dates <- incept_dates
    exp_dates <- exp_dates + years(1)
  }
  return(data.frame(incept_date=incept_dates,exp_date=exp_dates))
}

