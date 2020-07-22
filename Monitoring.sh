#!/bin/bash 


disks=/var/SP/pega

rm -f $disks/scripts/Monitoring.txt
echo $(date) >> $disks/scripts/Monitoring.txt 

for i in `cat $disks/scripts/hosts_list`;
        do
        echo $i >> $disks/scripts/Monitoring.txt
	ssh $i 'echo "FATAL"; grep -ci "FATAL" /var/SP/pega/logs/PegaRULES.log; echo "EXCEPTION"; grep -ci "EXCEPTION" /var/SP/pega/logs/PegaRULES.log; echo "ERROR"; grep -ci "ERROR" /var/SP/pega/logs/PegaRULES.log; echo " "' 2>/dev/null  >> $disks/scripts/Monitoring.txt
        done


