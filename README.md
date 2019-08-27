# RFM-table-on-online-retail
Cleaning data and forming RFM table of online retail data.

This is a transnational  data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail.The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers.

Load the Libraries:
library(tidyverse)
library(lubridate)
library(DataExplorer)

Load the data from source https://archive.ics.uci.edu/ml/datasets/online+retail in xlsx file

Preview the characteristics of the data

Check frequency of missing values for each feature
then
Drop rows which have no values of "CustomerID."

Forming new table frame
CustomerID | Recency | Frequency | Amount 

Recency   : number of days to the last transaction counted from today Dec 31, 2011

Frequency : number of transactions that have occurred in the past six (6) months

Monetary  : the amount of money spent by a unique CustomerID

End
