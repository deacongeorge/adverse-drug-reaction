###############################################################################
# case study: Adverse drug reaction data exploration
# source of data: open database https://api.fda.gov/drug/event.json?
# search=patient.reaction.reactionmeddrapt:"fatigue"+occurcountry:"ca"&limit=1
# https://api.fda.gov/drug/event.json?count=patient.reaction.reactionmeddrapt.exact
###############################################################################
#install packages & Import and reformating json files to R
###########################################################
#library("devtools") 
# install jsonlite
# library(jsonlite)
#JSON file was converted to csv as preferred to work in r data frame flat file and not deep nested list file 
############################################################################################################

j01data114 <- read.csv(file="C:/Users/yasser/Desktop/datatest/drug-event-000114.csv")     # reading csv data

head(j01data114)
jo1df <- as.vector(j01data114)                 #convert data structure to vector 
jo1df <- as.data.frame(j01data114)             # convert data structure to data frame
dim(j01data114)                                # view data frame dimensions dimention ? complete as in input?
head(j01data114)                               # Head and tail to see if data loaded is complete
tail(j01data114)                               # view tail as part of loading QC
summary(j01data114)                            # summary statistics of dataframe
################################################################################################
#Based on the summary will drop few columns with constant values and not needed
#the file columnsdrop contaions names of colums dropped
#################################################################################################

columnsdrop <- c("Document.Index..generated.", "Duplicate")                          # to remove multiple columns

j01data114 <- j01data114[, !names(j01data114) %in% columnsdrop, drop = F]
summary(j01data114)
###################################################################################
#Based on the summary will rename columns with long names
###################################################################################
colnames(j01data114)[which(colnames(j01data114) %in% c("Transmissiondate","Transmissiondateformat") )] <- c("Transdate","Transdateformat")
summary(j01data114)
head(j01data114)
#######################################################################################
#Sort dataframe based on Safetyreportid which is the unique identifier for all documents
arrange(df, weight)       # Used arrange from plyr package
df[ order(df$weight), ]   # r function
########################################################################################
library(plyr)
j01data114 <- arrange(j01data114, Safetyreportid)
summary(j01data114)
#######################################################################
statistical plots for adverse drug effect ( categorical variables)
####################################################################
install.packages("Lock5Data")
install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)
library(Lock5Data)
library(tapply
str(j01data114)
############################################################################################
#str shows the structure of the data int, factors or categorical/numerical variables
#This will guide in statistical plots.distribution of categories
############################################################################################
install.packages("gmodels")
library(gmodels)
CrossTable(j01data114$Occurcountry,j01data114$Reactionmeddrapt)    #crosstable between two categories
(country <- table(j01data114$Occurcountry))                          # frequency table
barplot(country, ylim=c(0, 500), xlab="Result", ylab="N", col="black", # bar plot for Occurcountry 
        main="Absolute frequency")

(reaction <- table(j01data114$Reactionmeddrapt))                          # frequency table
barplot(reaction, ylim=c(0, 500), xlab="Result", ylab="N", col="black", # bar plot for Occurcountry 
        main="Absolute frequency")
barplot(prop.table(country), ylim=c(0, 0.3), xlab="Result",     #plot of chunk
        ylab="relative frequency", col="gray50",
        main="Relative frequency")
##################################################################
# Handling missing values 
#############################################################################
countryna - is.na(country)
### Tested different metods for NA replacement as categorical values.
### missing value for a country was replaced with the regional median value
###  The country geographical map shows regional trend in adverse drug effect
##############################################################################







