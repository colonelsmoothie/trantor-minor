### Generates 50 pseudorandom policy inception dates for PY 2000
### This assumes that the date of origin is 1970-01-01

### Get the integer representation for 2000-01-01 (should be 10957)
from_date <- as.numeric(as.Date("2000-01-01"))
from_date

### Get the integer representation for 2001-01-01 (should be 11323)
to_date <- as.numeric(as.Date("2001-01-01"))
to_date

### Take 50 samples from the uniform distrubiton, with support specified by from and to dates
set.seed(250)
incept_dates <- runif(50,from_date,to_date)
class(incept_dates) <- 'Date'

incept_dates
