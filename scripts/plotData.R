setwd("~/Dropbox/projects/rocStats/scripts")

source("plotFcns.R")

##################
## rentals per item chart
rentalsPerItem <- read.csv(file='../tab_files/rentalsPerItem.tab', sep='\t', header=TRUE)

rentalsPerItem$Item = paste(rentalsPerItem$Activity, rentalsPerItem$ItemType, sep="-") 
rentalsPerItem$ItemOrdered <- reorder(rentalsPerItem$Item, rentalsPerItem$Count) 

barchart(rentalsPerItem[rentalsPerItem$Count > 10,], "ItemOrdered", "Count", "Activity", "Number of Rentals by Item", "Number Rented", "Item Type", "numberOfRentals")

##################
## time out plot
timeOutPerItem <- read.csv(file='../tab_files/timeOutPerItem.tab', sep='\t', header=TRUE)

timeOutPerItem$Item = paste(timeOutPerItem$Activity, timeOutPerItem$ItemType, sep="-") 
timeOutPerItem$ItemOrdered <- reorder(timeOutPerItem$Item, timeOutPerItem$AverageDaysOut)

timeOutPerItem$AverageDaysOut <- round(timeOutPerItem$AverageDaysOut)
barchart(timeOutPerItem, "ItemOrdered", "AverageDaysOut", "Activity", "Average Time Out", "Item Type", "Time Out", "timeOutByItem")

