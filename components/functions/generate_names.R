### function to randomly generate requested number of names

### Parameters
### n: number of names requested
### fseq: a vector of first names from which first names will be sampled
### lseq: a vector of last names from which last names will be sampled

generate_names <- function(n,fseq,lseq){
  FirstName <- c()
  LastName <- c()
  FirstName <- sample(fseq,n,replace=TRUE)
  LastName <- sample(lseq, n, replace=TRUE)
  return(data.frame(FirstName, LastName))
}