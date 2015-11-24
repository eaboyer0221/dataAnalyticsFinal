getwd()
setwd("C:/Users/Lenovo/Documents/MS_B_Analytics/Course_2_Data_Analytics/Term_Project/dataAnalyticsFinal")
rm(list = ls())
source("datacleaning.R")
library(dplyr)


users <- read.csv("data/users.csv")

userSelect <- select(users, RESPID:AGE, REGION, Q2, Q6, Q11, Q14:Q15)
names(userSelect) <- c("User", "Gender", "Age", "Region", "New.Music.Easy", "Unwilling.To.Pay", 
                       "Like.Pop.Music", "Love.Tech", "Tastemaker")

#Hierarchical clustering
userSelect2 <- (userSelect[,-c(1)])
#no scaling b/c values do not require it?
#calc distance

userSelect2 <- na.omit(userSelect2)
#code gender
userSelect2$Gender <- as.character(userSelect2$Gender)
userSelect2$Gender[userSelect2$Gender == "Female"] <- "1"
userSelect2$Gender[userSelect2$Gender == "Male"] <- "0"

userSelect3 <- userSelect2
userSelect3$Region <- as.character(userSelect3$Region)
userSelect3$Region[userSelect3$Region == "South"] <- "1"
userSelect3$Region[userSelect3$Region == "Midlands"] <- "2"
userSelect3$Region[userSelect3$Region == "North"] <- "3"
userSelect3$Region[userSelect3$Region == "Centre"] <- "4"
userSelect3$Region[userSelect3$Region == "Northern Ireland"] <- "5"
userSelect3$Region[userSelect3$Region == "North Ireland"] <- "6"
userSelect3$Region[userSelect3$Region == ""] <- NA
userSelect3 <- na.omit(userSelect3)

#Could do this way
g<- userSelect$Gender
gdummy <- model.matrix(~g)
userSelect$male <- gdummy[,2]
head(userSelect)
rdummy <- model.matrix(~userSelect$Region)

#euclidean distance
distance <- dist(userSelect3, method = 'euclidean')
#hcluster
userCluster <- hclust(distance,method='ward.D')
