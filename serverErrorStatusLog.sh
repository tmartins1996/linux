#author NB25172-Sérgio Ribeiro
#This script displays the Load Average and the number of StuckThreads,JTA and <Closing on GOWING_PRO_01.out

#minutes between checks
interval_check="1"
SKIP=0

while true; do

	dayNow=$(date +%d)
	monthNow=$(date +%m)
	yearNow=$(date +%Y)
	fileName="APP1_Server_Status_$dayNow$monthNow$yearNow.log"
	date +'%d %b %H:%M:%S' >> $fileName

	if [[ $SKIP -eq 0 ]]; then
	LoadAverage=$(cat /proc/loadavg | awk -F ' ' '{print $1}')
	StuckThreads=$(cat /var/SP/weblogic/config/PEGAPRD01/servers/pt1493yr/logs/pt1493yr.out |  grep -c 'STUCK' )
	JTA=$(cat /var/SP/weblogic/config/PEGAPRD01/servers/pt1493yr/logs/pt1493yr.out |  grep -c 'JTA')

	echo "----------------------------" >> $fileName
	echo "  " >> $fileName
	
	echo "LoadAverage(last minute): $LoadAverage" >> $fileName
	echo "Nº Stuckthreads: $StuckThreads" >> $fileName
	#echo "Nº Stuckthreads do LogViewer: $LogViewer" >> $fileName
	echo "Nº JTA: $JTA" >> $fileName
	
	echo " " >> $fileName
	sleep $(($interval_check*60))
	
	else
                echo "Time calculation failed, skipped this step." >> $fileName
                echo "  " >> $fileName
		SKIP=0
        fi
	
	
	done
exit
