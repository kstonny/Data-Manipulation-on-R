rm(list = ls()) #clearing the global enivornment

setwd("E:\\Rdata\\juica manu")
getwd()

#defining a variable which read the juice data set
drinks <- read.csv("juice.csv")

str(drinks) #very first we take struture of this data set

names(drinks) #total column

dim(drinks) #row n column

nrow(drinks)

ncol(drinks)

head(drinks) #first six observatiom

tail(drinks)

class(drinks) #it is a data frame 

#descriptive statitics / Summary statitics
summary(drinks)

#head of particular column

head(INCOME)#will show error because we drink is detached by default

head(drinks$INCOME) #first six observation of income variable

is.numeric(drinks$brand)

is.factor(drinks$store)

is.factor(drinks$brand)

#creating new variable which show all column of tropicana only

trop <- drinks[drinks$brand=="tropicana",]

str(trop)

#we want to see both tropicana  and dominic using pipe operator'|' satnds for OR means any of both of the them

tropdom <- drinks[drinks$brand =="tropicana"| drinks$brand=="dominicks",]

unique(tropdom$brand) #shows the level selected out of total level

str(tropdom)

as.factor(tropdom$brand)
head(tropdom)
tail(tropdom) 

#two or more locial statement 
#we want all brand name tropicana and no feature advertisement

trop3 <- drinks[drinks$brand=="tropicana"& drinks$feat==0,]

head(trop3)

str(trop3)

tail(trop3)

unique(trop3$brand)


#if we use & operator that is must be both of them

tropd <- drinks[drinks$brand =="tropicana"& drinks$brand=="dominicks",]

head(tropd) #if tropicana an dominic would be in different column then it will be useful

#tropd is 0 not useful so we remove it
rm(tropd)

#data for two col

repo <- drinks[,c("store","week")]#since we want two column we use c command that is concatinate

#for exact value n R help in 5 decimal only

INCOME1 <- drinks[drinks$INCOME=="10.55320518"| drinks$INCOME == "10.96648993",c("brand","week","store","INCOME")]

head(INCOME1)

str(INCOME1)

#for particular observation

drinks[2,3]

#fro muliple row n columm

drinks[c(1,2,5,468),c(1,8,5)]

# to acess the brand column element by name 

drinks[c(1:5),"brand"]

#using which operator
index<- which(drinks$brand=="tropicana") #also use for finding NA

index #index is vector here

class(index)

head(index)

#creating new column for log of income 

drinks$loginc<- log(drinks$INCOME) #it will add to the dataset at the end

#creating a new col of revenue with no. of unit sold and price of unit sold

head(drinks$logmove)
head(exp(drinks$logmove))

drinks$revenue<-(exp(drinks$logmove)*(drinks$price))
head(drinks$revenue)
dim(drinks)
names(drinks)

#revenue
drinks$revenue

#order
marks<- c(56,60,82,2,5,100)
order(marks) #ascending
marks[order(marks)]

order(-marks)#descending
marks[order(-marks)]

#order by week in juice data 
dat2 <- drinks[order(drinks$week),]
head(dat2)

#min of week column

min(drinks$week)

#order by descending week in juice data 
dat4 <- drinks[order(-drinks$week),]
head(dat4)

#summarizing by grouping the average prize of each brand
str(drinks)
aggregate(drinks$price, by=list(drinks$brand),mean) #by+list is factor only

# or 
tapply(drinks$price,(drinks$brand),mean)

#same for each income 

tapply(drinks$INCOME,(drinks$brand),mean)

#creating contingency table (help in catagorical variable)
#unit of different brand sold based on its feature advertisement run or not
table(drinks$brand,drinks$feat)

class(table(drinks$brand,drinks$feat)) #table class

#distribution of income by juice brand and whther feat advrs run or not
xtabs(drinks$INCOME~drinks$brand+drinks$feat)#distributing the table on base of two catagorical variable

#using dplyr package it is fast and eligent work on data frame

install.packages(("dplyr"))
library(dplyr)

#filter used for subsetting

dat8 <- filter(drinks,brand=="tropicana") #first data set will be there under ()

dim(filter(drinks,brand=="tropicana"))
dim(dat8)

dat9 <-filter(drinks,brand=="tropicana"|brand=="dominicks")
dim(dat9)
 
#to select specific col

dat10<-select(drinks,brand,INCOME,feat)
dat10

#we can drop also selected column through complete data set
dat11<-select(drinks,-brand,-INCOME,-feat)
dat11

#to create new column in an existing dataset with mutate command

dat12 <- mutate(drinks,logincome=log(INCOME))
dat12

#arrange fn

dat13 <- arrange(drinks,INCOME)
head(dat13)

dat14<- arrange(drinks,-INCOME) #In desc
head(dat14)

#group by summary

gr_brand <- group_by(drinks,brand)
summarize(gr_brand,mean(INCOME),sd(INCOME))

#fn pipeline

summarize(filter(drinks,INCOME>=10.5),mean(price))
#or
drinks%>%filter(INCOME>=10.5)%>%summarize(mean(price)) #Used mostly

#subset the database price>=2.5,create a column logincom,compute mean ,median n std deviation of logincom
drinks%>%filter(price>=2.5)%>%mutate(logincom=log(INCOME))%>%summarise(mean(logincom),sd(logincom),median(logincom))
