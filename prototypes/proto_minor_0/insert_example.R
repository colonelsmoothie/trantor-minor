### Establishes a connection to proto_minor_0, inserts a row into a table and then queries the table

library(RMySQL)

### We need to grant access to 'someuser' using the DB management system
con <- dbConnect(MySQL(), user="someuser",dbname = "proto_minor_0",
                    client.flag = CLIENT_MULTI_STATEMENTS)

script <- 'INSERT INTO Policy VALUES(1, "someguy");'
#script <- paste("SELECT * FROM Policy", "SELECT * FROM Policy", sep=";")

fetch(rs1)