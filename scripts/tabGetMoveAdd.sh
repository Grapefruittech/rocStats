# !/bin/bash

# remove tmp tab if there
sudo rm /tmp/*.tab -f
# create tab files
sudo mysql -u root -p < ~/rocStats/scripts/getData.sql
# move them to right folder
sudo mv /tmp/*.tab ~/rocStats/tab_files/

# add headers to columns
sed -i '1s/^/Activity\tItemType\tItemNumber\tName\tCount\n/' ../tab_files/itemSpecific.tab
sed -i '1s/^/Activity\tItemType\tName\tCount\n/' ../tab_files/rentalsPerItem.tab
sed -i '1s/^/Activity\tItemType\tName\tAverageDaysOut\n/' ../tab_files/timeOutPerItem.tab
