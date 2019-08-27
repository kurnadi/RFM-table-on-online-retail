# Title       : Cleaning & Formatting RFM Table of Online Retail Data 
# Description : This is an online retail script and its formatting process with RFM method.
# Objective   : To format data (after cleaning)
# Data source : https://archive.ics.uci.edu/ml/datasets/online+retail 

# This is a transnational  data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail.The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers.

# Load library
library(tidyverse)
library(lubridate)
library(DataExplorer)

# Load data
onlineretail <- readxl::read_xlsx('Online Retail.xlsx')

# Preview first 6 rows of data
head(onlineretail)

# Preview last 6 rows of data
tail(onlineretail)

# Summary of the data 
summary(onlineretail)

# Check frequency of missing values for each feature
plot_missing(onlineretail)

# Drop rows which have no values of "CustomerID."
onlineretail_drop <- onlineretail[!is.na(onlineretail$CustomerID),]

# Check any missing values after dropping
plot_missing(onlineretail_drop)

# Forming new table frame
# CustomerID | Recency | Frequency | Amount 
# Recency   : number of days to the last transaction counted from today Dec 31, 2011
# Frequency : number of transactions that have occurred in the past six (6) months
# Monetary  : the amount of money spent by a unique CustomerID

recency <- onlineretail_drop %>% group_by(CustomerID) %>% arrange(desc(InvoiceDate)) %>%  filter(row_number()==1) %>% mutate(recency = as.numeric(as.duration(interval(InvoiceDate,ymd("2011-12-31"))))/86400) %>% select(CustomerID, recency)
frequency <- onlineretail_drop %>% group_by(CustomerID) %>% summarise(frequency = n_distinct(InvoiceNo))
monetary <- onlineretail_drop %>% group_by(CustomerID) %>% summarise(monetary=sum(UnitPrice*Quantity))

# Joining the four variables making a data frame of "rfm"
df_rfm <- recency %>% left_join(frequency,by="CustomerID") %>% left_join(monetary,by="CustomerID")

# Summary of the df_rfm
summary(df_rfm)

# Make data with .csv file
write.csv(df_rfm, 'RFM of Online Retail.csv')

# End
