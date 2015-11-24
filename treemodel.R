rm(list = ls())
setwd("~/Classes/Fall/DataAnalytics/FinalProject/")
source("./datacleaning.R")

#Tree model
library(tree)
artist.tree <- tree(meanRating ~ . -Artist -User, data = master.cleaned)
plot(artist.tree)
text(artist.tree, pretty = 0)

#this is a comment