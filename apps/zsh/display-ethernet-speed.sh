#!/bin/bash
#
# Script to display ethernet wire speed as a desktop notification
#

#
# Interface to check is the first optional argument provided to the script.
#
INTERFACE="${1:-enp4s0}" # Defaults to current directory if no argument is given

speed=$(ethtool $INTERFACE 2>/dev/null|grep Speed|sed 's/^[[:space:]]*Speed://'|xargs)
# Mimic ternary logic safely
message=$([[ "$speed" == "1000Mb/s"* ]] && echo "All good: $speed" || echo "Warning: $speed")
notify-send "Ethernet Speed" "$message"
