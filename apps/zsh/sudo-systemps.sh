#!/bin/bash
# relies on sensors, smartctl

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

    temp=$(smartctl -a /dev/nvme0n1|grep 'Temperature:'|awk '{print $2}')
    echo "NVME: ${temp} °C"

    echo 'HDDs:'
    HDDS="/dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf"
    for disk in $HDDS
    do
        if [ -b $disk ]; then
            outp=$(smartctl -a ${disk})
            model=$(echo "${outp}"|grep 'Device Model:'|awk '{$1=$2=""; print $0}')
            temp=$(echo "${outp}"|grep '194\|190'|awk '{print $10}')
            temp=${temp%$'\n'*}
            temp=${temp%$'\n'*}
            echo "  ${disk}: ${temp}°C  ${model}"
        fi
    done

) > $TMPFILE

#sendmail -t < $TMPFILE
cat $TMPFILE
