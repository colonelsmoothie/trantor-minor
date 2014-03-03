### Establishes a connection to proto_minor_0, then lists the tables;

library(RMySQL)

### We need to grant access to 'someuser' using the DB management system
con <- dbConnect(MySQL(), user="someuser",dbname = "proto_minor_0")

dbListTables(con)

### We can also assign the results to a vector

pm0.tables <- dbListTables(con)
is.vector(pm0.tables)