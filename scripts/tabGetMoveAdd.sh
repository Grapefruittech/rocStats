# !/bin/bash

sudo rm /tmp/*.tab -f
sudo mysql -u root -p < ~/rocStats/sql_scripts/getData.sql

sudo mv /tmp/*.tab ~/rocStats/tab_files/

sed -i '1s/^/Activity\tItemType\tItemNumber\tName\tCount\n/' itemSpecific.tab
sed -i '1s/^/Activity\tItemType\tName\tCount\n/' rentalsPerItem.tab
sed -i '1s/^/Activity\tItemType\tName\tAverageDaysOut\n/' timeOutPerItem.tab
