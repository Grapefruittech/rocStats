setwd("~/Dropbox/projects/rocStats/scripts")

source("plotFcns.R")

##################
## rentals per item chart
rentalsPerItem <- read.csv(file='../tab_files/rentalsPerItem.tab', sep='\t', header=TRUE)

# make activty+itemtype
rentalsPerItem$Item = paste(rentalsPerItem$Activity, rentalsPerItem$ItemType, sep="-")
# order the data so the bars are in order
rentalsPerItem$ItemOrdered <- reorder(rentalsPerItem$Item, rentalsPerItem$Count)

# make vertical barchart of data
barchart(rentalsPerItem[rentalsPerItem$Count > 5,], "ItemOrdered", "Count", "Activity", "Number of Rentals by Item", "Number Rented", "Item Type", "numberOfRentals")

##################
## time out plot
timeOutPerItem <- read.csv(file='../tab_files/timeOutPerItem.tab', sep='\t', header=TRUE)

# make activity+itemtype
timeOutPerItem$Item = paste(timeOutPerItem$Activity, timeOutPerItem$ItemType, sep="-")
# order the data so the bars are in order
timeOutPerItem$ItemOrdered <- reorder(timeOutPerItem$Item, timeOutPerItem$AverageDaysOut)

# round the rental days out so they look nicer
timeOutPerItem$AverageDaysOut <- round(timeOutPerItem$AverageDaysOut)
# create vertical bar chart
barchart(timeOutPerItem, "ItemOrdered", "AverageDaysOut", "Activity", "Average Time Out", "Item Type", "Time Out", "timeOutByItem")
