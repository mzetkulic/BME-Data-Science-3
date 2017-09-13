library(readr)
library(dplyr)
library(ISwR)
library(ggplot2)
library(reshape2)
library(tidyr)
library(UsingR)
library(plyr)

cleveland <- read_csv(file="processed.cleveland.data.csv",col_names=FALSE)
swiss <- read_csv(file="processed.hungarian.data.csv",col_names=FALSE)
va <- read_csv(file="processed.va.data.csv",col_names=FALSE)
hungary <- read_csv(file="processed.switzerland.data.csv",col_names=FALSE)

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

