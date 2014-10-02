library(ggplot2)
library(grid)
library(RColorBrewer)


## rentals per item chart
rentalsPerItem <- read.csv(file='tab_files/rentalsPerItem.tab', sep='\t', header=TRUE)

rentalsPerItem$Item = paste(rentalsPerItem$Activity, rentalsPerItem$ItemType, sep="-") 
rentalsPerItem$ItemOrdered <- reorder(rentalsPerItem$Item, rentalsPerItem$Count)

ggplot(rentalsPerItem[rentalsPerItem$Count > 10,],aes(x = ItemOrdered, y = Count, fill = Activity)) +
  # bar chart
  geom_bar(stat='identity') +
  geom_text(aes(label=Count), position=position_dodge(width=0.9), hjust=-.5, vjust= .4) +
  coord_flip() + 
  theme_bw() +
  # Set the entire chart region to a light gray color
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  # Format the grid
  theme(panel.grid.major=element_blank()) +
  theme(panel.grid.minor=element_blank()) +
  theme(axis.ticks=element_blank()) +
  # Dispose of the legend
  #theme(legend.position="none") +
  theme(legend.background=element_rect(fill="#F0F0F0")) +
  # Set title and axis labels, and format these and tick marks
  ggtitle("Number of Rentals by Item") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=20)) +
  ylab("Number Rented") +
  xlab("Item Type") +
  theme(axis.text.x=element_blank()) +
  theme(axis.text.y = element_text()) +
  theme(axis.title.y=element_text(size=11,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_text(size=11,colour="#535353",face="bold",vjust=-.5)) +
  # Plot margins and finally line annotations
  theme(plot.margin = unit(c(1, 1, .5, .7), "cm")) +
  scale_fill_brewer(palette="Paired")
  
ggsave(filename="images/numberOfRentals.png",width=40, height=60, units="cm", dpi=600)




## time out plot
timeOutPerItem <- read.csv(file='tab_files/timeOutPerItem.tab', sep='\t', header=TRUE)

timeOutPerItem$Item = paste(timeOutPerItem$Activity, timeOutPerItem$ItemType, sep="-") 
timeOutPerItem$ItemOrdered <- reorder(timeOutPerItem$Item, timeOutPerItem$AverageDaysOut)

ggplot(timeOutPerItem,aes(x = ItemOrdered, y = AverageDaysOut, fill = Activity)) +
  # bar chart
  geom_bar(stat='identity') +
  geom_text(aes(label=AverageDaysOut), position=position_dodge(width=0.9), hjust=-.5, vjust= .4) +
  coord_flip() + 
  theme_bw() +
  # Set the entire chart region to a light gray color
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  # Format the grid
  theme(panel.grid.major=element_blank()) +
  theme(panel.grid.minor=element_blank()) +
  theme(axis.ticks=element_blank()) +
  # Dispose of the legend
  #theme(legend.position="none") +
  theme(legend.background=element_rect(fill="#F0F0F0")) +
  # Set title and axis labels, and format these and tick marks
  ggtitle("Average Time Out") +
  theme(plot.title=element_text(face="bold",hjust=-.04,vjust=2,colour="#3C3C3C",size=20)) +
  ylab("Time Out") +
  xlab("Item Type") +
  theme(axis.text.x=element_blank()) +
  theme(axis.text.y = element_text()) +
  theme(axis.title.y=element_text(size=11,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_text(size=11,colour="#535353",face="bold",vjust=-.5)) +
  # Big bold line at y=0
  geom_hline(yintercept=0,size=1.2,colour="#535353") +
  # Plot margins and finally line annotations
  theme(plot.margin = unit(c(1, 1, .5, .7), "cm")) +
  scale_fill_brewer(palette="Paired")
  #annotate("text",x=14.7,y=15.3,label="Line 1",colour="#f8766d") +
  #annotate("text",x=25,y=7.5,label="Line 2",colour="#00bdc4")


ggsave(filename="images/timeOutByItem.png",width=70, height=60, units="cm", dpi=600)

