#!/bin/sh

dir=/var/SP/pega/scripts
file="PegaNodes.txt"
rm -f $dir/PegaNodes.txt

declare -a PROCESSES=(
        "Admin Dweblogic.Name=admin"
        "NodeManeger weblogic.NodeManager"
        "Node Dweblogic.Name=pt"
        )

declare -a PROCESSES_TO_MONITOR_LOCAL=(
        "Admin"
        #"NodeManeger"
        "Node"
        )

declare -a PROCESSES_TO_MONITOR_REMOTE=(
        #"NodeManeger"
        "Node"
)



for PROCESS in "${PROCESSES[@]}"
do
        proc=$(echo $PROCESS | awk '{print $1}')
        #LOCAL CHECK
        for PROCESS_TO_MONITOR in "${PROCESSES_TO_MONITOR_LOCAL[@]}"
        do
                if [ $proc == $PROCESS_TO_MONITOR ]
                then
                        search=$(echo $PROCESS | awk '{print $2}')
                        running=$(ps -ef | grep -v grep | grep $search | wc -l)
                        if [ $running -eq 0 ]
                        then
                             echo $proc "is not running on pt1493yr" >> $dir/$file
                        fi
                fi

        done
        
	#REMOTE CHECK
        for PROCESS_TO_MONITOR in "${PROCESSES_TO_MONITOR_REMOTE[@]}"
        do
                if [ $proc == $PROCESS_TO_MONITOR ]
                then
                        search=$(echo $PROCESS | awk '{print $2}')
                        for i in `grep -v pt1493yr $dir/hosts_list`
			do
			running=$(ssh $i "ps -ef" 2>/dev/null | grep -v grep | grep $search | wc -l)
                        if [ $running -eq 0 ]
                        then
				echo $proc "in not running on" $i >> $dir/$file
			fi

			done
                fi
        done
done
