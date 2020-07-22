#!/bin/bash

memThreshold=96
swapThreshold=75
path=/var/SP/pega/scripts

rm -f $path/MemSwapPega.txt

echo "Memory (memThreshold=$memThreshold):" >> $path/MemSwapPega.txt;

for i in `cat $path/hosts_list`; 
	do 
		mem=$( ssh $i "echo `free | sed -n '2p' | awk '{print $3}'`/`free | sed -n '2p' | awk '{print $2}'` | bc -l | cut -c2-3" 2>/dev/null );
		buff=$( ssh $i "echo `free -m | sed -n '2p' | awk '{print $7}' `" 2>/dev/null );
		
		if [ $mem -ge $memThreshold ]; 
		then 
			echo " " $i "-" $mem"%    ("$buff"mb in cache)"  >> $path/MemSwapPega.txt; 
		fi ; 

	done

echo -e "\nSwap (swapThreshold=$swapThreshold):" >> $path/MemSwapPega.txt;

for i in `cat $path/hosts_list`;
        do
                swap=$( ssh $i "echo `free | sed -n '3p' | awk '{print $3}'`/`free | sed -n '3p' | awk '{print $2}'` | bc -l | cut -c2-3" 2>/dev/null );

                if [ $swap -ge $swapThreshold ];
                then
                        echo " " $i "-" $swap"%"  >> $path/MemSwapPega.txt;
                fi ;

        done

if [[ $(sed -n '2p' $path/MemSwapPega.txt | grep pt | wc -l) -eq 0 ]];
then
	sed '1, 2d' $path/MemSwapPega.txt > $path/MemSwapPega1.txt
  	mv $path/MemSwapPega1.txt $path/MemSwapPega.txt
fi

if [[ $(sed -n '$p' $path/MemSwapPega.txt | grep pt | wc -l) -eq 0 ]];
then
	sed '$d' $path/MemSwapPega.txt > $path/MemSwapPega1.txt
        mv $path/MemSwapPega1.txt $path/MemSwapPega.txt
fi

if [[ $(cat $path/MemSwapPega.txt | wc -l) -eq 0 ]];
then
      rm $path/MemSwapPega.txt;
fi

cat $path/MemSwapPega.txt;

