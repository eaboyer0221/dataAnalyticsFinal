rm(list = ls())
#setwd("~/Classes/Fall/DataAnalytics/FinalProject/")
library(dplyr)


#Load data set
words <- read.csv("./data/words.csv")

#Remove uncommon words
words.cleaned <- words %>% select(Artist, User, HEARD_OF, Aggressive, Edgy, Current, Stylish, 
                                  Cheap, Calm, Outgoing, Inspiring, Beautiful, Fun, 
                                  Authentic, Credible, Cool, Catchy, Sensitive, 
                                  Superficial, Passionate, Timeless, Original,
                                  Talented, Distinctive, Approachable, Trendsetter, 
                                  Noisy, Upbeat, Depressing, Energetic, Sexy,
                                  Fake, Cheesy, Unoriginal, Dated, Unapproachable,
                                  Classic, Playful, Arrogant, Warm, Serious, 
                                  Good.lyrics, Unattractive, Confident, Youthful,
                                  Thoughtful)

#Removing blank HEARD_OF
words.cleaned <- filter(words.cleaned, HEARD_OF != "")

#Converting HEARD_OF to two factors
heardof <- words.cleaned$HEARD_OF
heardof <- as.character(heardof)
heardof[heardof != "Never heard of"] <- "Heard of"
words.cleaned$HEARD_OF <- heardof
words.cleaned$HEARD_OF <- as.factor(words.cleaned$HEARD_OF)


#Load train set
train <- read.csv("./data/train.csv")

#Create mean rating for artists
train.group <- group_by(train, Artist, User)
trainSumm <- summarise(train.group, meanRating = mean(Rating))

#merge with word set
master <- inner_join(trainSumm, words.cleaned)

#Check for NAs
apply(master, 2, function(x) table(is.na(x)))


#Clean master data
master.cleaned <- select(master, -Aggressive, -Cheap, -Calm, -Outgoing, -Inspiring,
                         -Catchy, -Sensitive, -Superficial, -Upbeat, -Depressing, 
                         -Fake, -Cheesy, -Unoriginal, -Dated, -Unapproachable, 
                         -Classic, -Playful, -Arrogant, -Serious, -Good.lyrics, 
                         -Unattractive, -Confident, -Youthful, -Noisy)


#write.csv(master.cleaned, "master.csv")

#Create some summaries and initial models
master.cleaned2 <- select(master.cleaned, -User, -HEARD_OF)
master.group <- group_by(master.cleaned2, Artist)
master.Summ <- summarise_each(master.group, funs(mean))
master.Summ <- master.Summ %>% arrange(desc(meanRating))
fit <- lm(meanRating ~ . - Artist, data = master.Summ)
x <- cor(master.Summ[,3:21])

