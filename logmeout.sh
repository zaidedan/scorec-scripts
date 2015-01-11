# SCOREC-SCRIPT
# DANIEL W. ZAIDE, 01/11/2015
# This script is used to log myself out of idle procs (greater than 30 minutes)
# modified from http://www.linuxquestions.org/questions/linux-general-1/kill-all-idle-user-processes-845141/
# Usage: logmeout

#!/bin/bash

# get idle times of ttys
for i in $(w | sed '1,2d' | awk '{OFS = ","} ; { print $1, $2, $5 }' | sed 's/:.*$//' | sed -e '/^.*[0-9]s$/d') ; do
	idletime=$( echo $i | awk 'BEGIN {FS = ","} ; { print $3 }')
	user=$(echo $i | awk 'BEGIN {FS = ","} ; { print $1 }')
	# if we are dealing in days, just set to be big
	if [ "$( echo $idletime | grep 'days' )" ]; then
	   idletime=100000
	fi
	# if idle time is greater than thirty minutes, get corresponding PIDs of these ttys
	if [ "$idletime" -gt 1 ] && [ "$user" == "zaided" ]; then
		TTYTOKILL=$(echo "$i" | awk 'BEGIN {FS = ","} ; {print $2}' | sed 's/^.*\///')
		NEWPIDSTOKILL=$(ps -t $TTYTOKILL | grep 'pts' | awk '{print $1}')
		PIDSTOKILL=$(echo $PIDSTOKILL $NEWPIDSTOKILL)
	fi
done
if [ -n "$PIDSTOKILL" ]; then
echo "killing:"
for ps in $PIDSTOKILL;
do
ps -f -p $ps | sed '1d'
echo $ps
kill $(echo $ps)
done
sleep 10
for ps in $PIDSTOKILL;
do
echo $ps
kill -9 $(echo $ps)
done
else
echo "none"
fi