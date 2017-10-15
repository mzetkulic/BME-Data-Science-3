# Thank  you to the following researchers for the data:
#   
#   1. Hungarian Institute of Cardiology. Budapest: Andras Janosi, M.D.
# 2. University Hospital, Zurich, Switzerland: William Steinbrunn, M.D.
# 3. University Hospital, Basel, Switzerland: Matthias Pfisterer, M.D.
# 4. V.A. Medical Center, Long Beach and Cleveland Clinic Foundation:
#   Robert Detrano, M.D., Ph.D.


library(readr)
library(dplyr)
library(ISwR)
library(ggplot2)
library(reshape2)
library(tidyr)
library(UsingR)
library(plyr)

cleveland <- read.csv(file="processed.cleveland.data.csv",header=FALSE)
swiss <- read.csv(file="processed.hungarian.data.csv",header=FALSE)
va <- read.csv(file="processed.va.data.csv",header=FALSE)
hungary <- read.csv(file="processed.switzerland.data.csv",header=FALSE)

namesvec <- c("age","sex","cp","trestbps","chol","fbs","restecg","thalach","exang"    
                      ,"oldpeak"  
                      ,"slope"  
                      ,"ca"        
                      ,"thal"    
                      ,"num")

names(cleveland) <- namesvec
names(swiss) <- namesvec
names(va) <- namesvec
names(hungary) <- namesvec

all <- rbind(cleveland,swiss,va,hungary)

all <- all[!is.na(as.numeric(as.character(all$age))),]
all <- all[!is.na(as.numeric(as.character(all$sex))),]
all <- all[!is.na(as.numeric(as.character(all$trestbps))),]
all <- all[!is.na(as.numeric(as.character(all$chol))),]
all <- all[!is.na(as.numeric(as.character(all$fbs))),]
all <- all[!is.na(as.numeric(as.character(all$restecg))),]
all <- all[!is.na(as.numeric(as.character(all$thalach))),]
all <- all[!is.na(as.numeric(as.character(all$exang))),]
all <- all[!is.na(as.numeric(as.character(all$oldpeak))),]
all <- all[!is.na(as.numeric(as.character(all$slope))),]
all <- all[!is.na(as.numeric(as.character(all$cp))),]
all <- all[!is.na(as.numeric(as.character(all$ca))),]
all <- all[!is.na(as.numeric(as.character(all$thal))),]
all <- all[!is.na(as.numeric(as.character(all$num))),]

allclean <- all

write.csv(allclean,"14clean.csv")

allnew <- as.numeric(as.character(all$age))
na.omit(allnew)
allnew[is.na(all$restecg)]


allclean <- all %>% filter(!(age=="?")) %>% filter(!(sex=="?")) %>% filter(!(trestbps=="?")) %>% filter(!(num=="?"))
# removing "?" values for relevant columns

allclean <- allclean %>% filter(!(chol=="?"))

allclean <- transform(allclean, trestbps = as.numeric(chol))
allclean <- transform(allclean, age = as.numeric(age))
allclean <- transform(allclean, sex = as.numeric(sex))
allclean <- transform(allclean, chol = as.numeric(chol))

allclean[,14] <- pmin(allclean$num,1)

fit <- rpart(num ~ chol,data=allclean,method="class")

library(randomForest)
fit <- randomForest(num ~ chol + age + trestbps + sex,data=allclean)
print(fit) # view results 
importance(fit) # importance of each predictor
