#author NB25172-Sérgio Ribeiro
#This script displays the Load Average and the number of StuckThreads,JTA and <Closing on GOWING_PRO_01.out





#CurrentTime=$(date | awk -F' ' '{print $4}' | awk -F':' '{print $1}' | sed 's/ /:/g')
#PreviousTime=$( date -d '1 hour ago' "+%m/%d/%Y -%H:%M:%S" | awk -F' ' '{print $2}' | awk -F'-' '{print $2}' | awk -F':' '{print $1}' | sed 's/ /:/g')
#PreviousTime=$( date -d '10 minutes ago' "+%m/%d/%Y -%H:%M:%S" | awk -F' ' '{print $2}' | awk -F'-' '{print $2}' | awk -F':' '{print $1,$2}' | sed 's/ /:/g')

dayNow=$(date +%d)
monthNow=$(date +%m)
yearNow=$(date +%Y)
Filename="APP1_CONN_TEST_$dayNow$monthNow$yearNow.log"

LoadAverage=$(cat /proc/loadavg | awk -F ' ' '{print $1}')
StuckThreads=$(cat /var/SP/weblogic/config/PEGAPRD01/servers/pt1493yr/logs/pt1493yr.out  |  grep -c 'STUCK' )
JTA=$(cat /var/SP/weblogic/config/PEGAPRD01/servers/pt1493yr/logs/pt1493yr.out  |  grep -c 'JTA transaction unexpectedly rolled back')



echo ""
#echo "Server status between $PreviousTime h and now"
echo "LoadAverage(last minute): $LoadAverage"
echo "Nº Stuckthreads: $StuckThreads"
echo "Nº JTA: $JTA"
#echo "Nº <Closing: $Closing" 

##echo "Tempo de ligação à BD(milisegundos): $DBTime"
#echo "Tempo de ligação à BD do Nó A(milisegundos): $ATime"
##echo "Tempo de ligação à BD do Nó B(milisegundos): $BTime"
echo ""
echo ""
