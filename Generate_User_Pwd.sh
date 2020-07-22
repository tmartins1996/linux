read -sp 'Current Password: ' oldpwd

NEXT=''
NEXT+=$(echo `date +"%Y%m%d"` | sha256sum | sed 's/[0-9]*//g' | cut -c 1-2 | tr [A-Z] [a-z])
NEXT+=$(echo `date +"%Y%m%d"` | sha256sum | cut -c 10-15 | tr [a-z] [A-Z])
NEXT+=$(echo `date +"%Y%m%d"` | sha256sum | sed 's/[0-9]*//g' | cut -c 3-4 | tr [a-z] [A-Z])
NEXT+=$(echo `date +"%Y%m%d"` | sha256sum | cut -c 16-20 | tr [A-Z] [a-z])
NEXT+='?'

echo "New Password Generated:"
echo $NEXT


#PT1493YR

 for i in `cat /var/SP/pega/scripts/hosts_list`;    do echo $i ; ssh $i 'echo -e "$oldpwd\n$NEXT\n$NEXT" | passwd' 2>/dev/null; done;
 for i in `cat /var/SP/pega/scripts/hosts_list_Kafka`;    do echo $i ; ssh kfkaprd2@$i 'echo -e "$oldpwd\n$NEXT\n$NEXT" | passwd' 2>/dev/null; done;
