#!/bin/sh
# relies on sensors, nvme, hddtemp

# cleanup
rm -f /tmp/temps_????????_??????

now=$(date +"%Y%m%d_%H%M%S")
TMPFILE="/tmp/temps_$now"

adastat () {
  # this emits:
  # status, error, lba_low, lba_mid, lba_high, device, lba_low_exp, lba_mid_exp, lba_high_exp, sector_count, sector_count_exp
  echo `camcontrol cmd $1 -a "E5 00 00 00 00 00 00 00 00 00 00 00" -r - | awk '{print $10 " " ; }'` " " ;
}
(
  #echo "To: your email address"
  #echo "Subject: System Temperatures INFO"
  #echo " "
  echo System temperatures - `date`
  echo "$(uname -nsrm), $(cat /etc/version)"

  echo -n 'System load: '
  uptime | sed -n -e 's/^.*load averages: //p'
  # this does not work if CPU is virtualized
  echo "CPUs:"
  sysctl -a | egrep -E "cpu\.[0-9]+\.temp" | awk '{ print $2 }'

  #echo -e 'HDDs Activity Status'
  #for i in $(sysctl -n kern.disks | awk '{for (i=NF; i!=0 ; i--) if(match($i, '/ada/')) print $i }' )
  #do
  #  echo -n $i:;adastat $i
  #done

  echo -e 'HDDs:'
  for i in $(sysctl -n kern.disks | awk '{for (i=NF; i!=0 ; i--) if(match($i, '/ada/')) print $i }' )
  do
    echo $i `smartctl -a /dev/$i|awk '/Temperature_Celsius/{DevTemp=$10;} /Serial Number:/{DevSerNum=$3} END { printf "%-25s %s°C\n",DevSerNum,DevTemp }'`
  done
  echo
) > $TMPFILE

#sendmail -t < $TMPFILE
cat $TMPFILE
