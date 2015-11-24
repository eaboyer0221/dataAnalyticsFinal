setwd("~/Classes/Fall/DataAnalytics/FinalProject/")
rm(list = ls())
source("./datacleaning.R")
library(dplyr)


users <- read.csv("data/users.csv")

userSelect <- select(users, RESPID:AGE, REGION, Q2, Q6, Q11, Q14:Q15)
names(userSelect) <- c("User", "Gender", "Age", "Region", "New.Music.Easy", "Unwilling.To.Pay", 
                       "Like.Pop.Music", "Love.Tech", "Tastemaker")

