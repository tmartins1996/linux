#!/bin/bash

smtpHost=smtp.vf-pt.internal.vodafone.com
smtpPort=25
email="tiago.martins3@vodafone.com sara.ribeiro5@vodafone.com"
threshold=85
disks=/var/SP/pega

rm -f $disks/scripts/MaxDiskUsage.txt

for i in `cat $disks/scripts/hosts_list`; 
	do 
		current=$(ssh $i "df -hP | grep $disks" 2>/dev/null |awk '{print $5}'| awk -F"%" '{print $1}' );
		if [[ $current -ge $threshold ]]; then echo $i "-" $current"%"  >> $disks/scripts/MaxDiskUsage.txt; fi ; 
	done

