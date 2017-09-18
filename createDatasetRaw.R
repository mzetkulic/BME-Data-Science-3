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

ColNames <- c('id','ccf','age','sex','painloc','painexer','relrest','pncaden','cp','trestbps','htn','chol','smoke','cigs','years','fbs','dm','famhist','restecg','ekgmo','ekgday','ekgyr','dig','prop','nitr','pro','diuretic','proto','thaldu','thaltime','met','thalach','thalrest','tpeakbps','tpeakbpd','dummy','trestbpd','exang','xhypo','oldpeak','slope','rldv5','rldv5e','ca','restckm','exerckm','restef','restwm','exeref','exerwm','thal','thalsev','thalpul','earlobe','cmo','cday','cyr','num','lmt','ladprox','laddist','diag','cxmain','ramus','om1','om2','rcaprox','rcadist','lvx1','lvx2','lvx3','lvx4','lvf','cathef','junk','name','na','na','na','na')


cleveland <- read.csv(file="cleveland.data.csv",sep=' ',header=FALSE)
hungary <- read.csv(file="hungarian.data.csv",sep=' ',header=FALSE)
va <- read.csv(file="long-beach-va.data.csv",sep=' ',header=FALSE)
swiss <- read.csv(file="switzerland.data.csv",sep=' ',header=FALSE)

for (i in seq(1,nrow(swiss),10)){
  a <- swiss[i,]
  for (j in 1:9){
    b <- swiss[i+j,]
    a <- cbind(a,b)
  }
  names(a) <- ColNames
  if (i==1){
    swissclean <- a
  } else {
    swissclean <- rbind.fill(swissclean,a)
  }
}

for (i in seq(1,nrow(va),10)){
  a <- va[i,]
  for (j in 1:9){
    b <- va[i+j,]
    a <- cbind(a,b)
  }
  names(a) <- ColNames
  if (i==1){
    vaclean <- a
  } else {
    vaclean <- rbind.fill(vaclean,a)
  }
}

for (i in seq(1,nrow(cleveland),10)){
  a <- cleveland[i,]
  for (j in 1:9){
    b <- cleveland[i+j,]
    a <- cbind(a,b)
  }
  names(a) <- ColNames
  if (i==1){
    clevelandclean <- a
  } else {
    clevelandclean <- rbind.fill(clevelandclean,a)
  }
}

for (i in seq(1,nrow(hungary),10)){
  a <- hungary[i,]
  for (j in 1:9){
    b <- hungary[i+j,]
    a <- cbind(a,b)
  }
  names(a) <- ColNames
  if (i==1){
    hungaryclean <- a
  } else {
    hungaryclean <- rbind.fill(hungaryclean,a)
  }
}

all <- rbind(clevelandclean,swissclean,vaclean,hungaryclean)
all <- na.omit(all)
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

library(randomForest)

#fit <- randomForest(num ~
#                       id + ccf + age + sex + painloc + painexer + relrest + pncaden + cp + trestbps + htn + chol + smoke + cigs + years + fbs + dm + famhist + restecg + ekgmo + ekgday + ekgyr + dig + prop + nitr + pro + diuretic + proto + thaldu + thaltime + met + thalach + thalrest + tpeakbps + tpeakbpd + dummy + trestbpd + exang + xhypo + oldpeak + slope + rldv5 + rldv5e + ca + restckm + exerckm + restef + restwm + exeref + exerwm + thal + thalsev + thalpul + earlobe + cmo + cday + cyr + num + lmt + ladprox + laddist + diag + cxmain + ramus + om1 + om2 + rcaprox + rcadist + lvx1 + lvx2 + lvx3 + lvx4 + lvf + cathef + junk + name + na + na + na + na
#                     ,data=all)
#print(fit) # view results
#importance(fit) # importance of each predictor
