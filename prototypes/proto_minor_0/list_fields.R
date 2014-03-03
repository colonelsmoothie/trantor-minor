### Establishes a connection to proto_minor_0, then lists the fields for each table;

library(RMySQL)

### We need to grant access to 'someuser' using the DB management system
con <- dbConnect(MySQL(), user="someuser",dbname = "proto_minor_0")

tbl <- dbListTables(con)

for(i in tbl){
  print(dbListFields(con,i))
}