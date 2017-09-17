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
library(rvest)
library(plyr)

cleveland <- read_csv(file="cleveland.data.csv",col_names=FALSE)
hungary <- read_csv(file="hungarian.data.csv",col_names=FALSE)
va <- read_csv(file="long-beach-va.data.csv",col_names=FALSE)
swiss <- read_csv(file="switzerland.data.csv",col_names=FALSE)

namesvec <- c("age","sex","cp","trestbps","chol","fbs","restecg","thalach","exang"    
              ,"oldpeak"  
              ,"slope"  
              ,"ca"        
              ,"thal"    
              ,"num")

# names(cleveland) <- namesvec
# names(swiss) <- namesvec
# names(va) <- namesvec
# names(hungary) <- namesvec
# 
# all <- rbind(cleveland,swiss,va,hungary)
# 
# allclean <- all %>% filter(!(age=="?")) %>% filter(!(sex=="?")) %>% filter(!(trestbps=="?")) %>% filter(!(num=="?"))
# # removing "?" values for relevant columns
# 
# allclean <- allclean %>% filter(!(chol=="?"))
# 
# allclean <- transform(allclean, trestbps = as.numeric(chol))
# allclean <- transform(allclean, age = as.numeric(age))
# allclean <- transform(allclean, sex = as.numeric(sex))
# allclean <- transform(allclean, chol = as.numeric(chol))
# fit <- rpart(num ~ chol,data=allclean,method="class")
# 
# library(randomForest)
# fit <- randomForest(num ~ chol + age + trestbps + sex,data=allclean)
# print(fit) # view results 
# importance(fit) # importance of each predictor
