#!/bin/bash

disks=/var/SP/pega

for i in `cat $disks/scripts/hosts_list`;
        do
        ssh $i 'find /var/SP/pega/logs/ -type f -mtime +15 -exec rm {} \;' 2>/dev/null 
        done

