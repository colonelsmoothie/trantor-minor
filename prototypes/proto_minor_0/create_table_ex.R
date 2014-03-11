### This example creates a table and then drops it. You'll need the proper permissions to do this

library(RMySQL)

### We need to grant access to 'someuser' using the DB management system
con <- dbConnect(MySQL(), user="someuser",dbname = "proto_minor_0")

### Show the tables
tables <-dbListTables(con)
tables

### Create table Policy2 with the following query
dbGetQuery(con, "CREATE TABLE IF NOT EXISTS Policy2 (
                 Policy_ID INT NOT NULL,
                 PolicyHolder VARCHAR(45) NOT NULL,
                 PRIMARY KEY (Policy_ID));")

### Show the tables
tables <-dbListTables(con)
tables

### Get a description of our new table
dbGetQuery(con, "DESC Policy2;")

### Delete the table we just made
dbGetQuery(con, "DROP TABLE Policy2;")

### Show the tables, notice Policy2 is no longer there
tables <-dbListTables(con)
tables
