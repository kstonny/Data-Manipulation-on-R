# Importing a csv file use read function with csv file
# to start working omn oj named file data
# if u are importing a text file than while importing that file also type
# header is equal to true as numeric will become value undera column

getwd()
drinks <- read.csv("juice.csv")




# how to run sql queries inside R 
# using a package sqldf
# this package is available ata CRAN 
install.packages("sqldf")
library(sqldf)
# now in order to use the sql commands in R 
# let ws do some knkwn commands
# using the select statement
drinks_s <- sqldf("select brand,income,feat from drinks")

# using the where statements
# subsetting using the where statement
drinks_s0 <- sqldf("select brand,income,feat from drinks price<3.8 and income<10")

# using order by statemenet
drinks_s1 <- sqldf("select store,brand,week,logmove ,feat,price , income from drinks order by income asc")

