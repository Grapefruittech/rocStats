# !/bin/bash

sudo rm /tmp/*.tab -f
sudo mysql -u root -p < ~/rocStats/scripts/getData.sql

sudo mv /tmp/*.tab ~/rocStats/tab_files/

sed -i '1s/^/Activity\tItemType\tItemNumber\tName\tCount\n/' ../tab_files/itemSpecific.tab
sed -i '1s/^/Activity\tItemType\tName\tCount\n/' ../tab_files/rentalsPerItem.tab
sed -i '1s/^/Activity\tItemType\tName\tAverageDaysOut\n/' ../tab_files/timeOutPerItem.tab
