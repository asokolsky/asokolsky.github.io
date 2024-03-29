#!/bin/sh
# relies on sensors, nvme, hddtemp

# cleanup
rm -f /tmp/temps_????????_??????

now=$(date +"%Y%m%d_%H%M%S")
TMPFILE="/tmp/temps_$now"
(
    #echo "To: your email address"
    #echo "Subject: System Temperatures INFO"
    #echo " "
    echo System temperatures - `date`
    echo "$(uname -nsrm), $(uptime -p)"
    cat /proc/loadavg | awk '{ print "System load:",$1,$2,$3 }'

    # this does not work if CPU is virtualized
    temp=$(sensors|grep Package|awk '{print $4}')
    echo "CPU: $temp"

    temp=$(nvme smart-log /dev/nvme0|grep temperature|awk '{print $3}')
    echo "NVME: $temp°C"

    echo 'HDDs:'
    HDDS="/dev/sda /dev/sdb /dev/sdc /dev/sdc /dev/sdd /dev/sde"
    for disk in $HDDS
    do
        if [ -b $disk ]; then
            hddtemp ${disk}
        fi
    done

) > $TMPFILE

#sendmail -t < $TMPFILE
cat $TMPFILE
