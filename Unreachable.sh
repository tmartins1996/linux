#!/bin/bash

disks='/var/SP/pega/scripts'

rm -f $disks/Unreachable.txt

Hour=$(date +%H)
HControl=$(date --date='07:00:00' +%H)

if [[ $Hour -lt $HControl ]];
then 
for i in `cat /var/SP/pega/scripts/hosts_list`;
do
ssh $i 'echo "1" > /var/SP/pega/scripts/last_run.txt' 2>/dev/null
done
fi

for i in `cat $disks/hosts_list`;
	do 
	if [[ $(ssh $i "bash -s" < $disks/Unreachable_aux.sh 2>/dev/null) -ne 0 ]];
	then 
	echo $i  >> $disks/Unreachable.txt;
	ssh $i 'grep -li "UNREACHABLE" /var/SP/pega/logs/PegaRULES.log' 2>/dev/null >> $disks/Unreachable.txt;
	fi
	ssh $i 'echo $(wc -l /var/SP/pega/logs/PegaRULES.log | cut -d " " -f 1) > /var/SP/pega/scripts/last_run.txt' 2>/dev/null

done
