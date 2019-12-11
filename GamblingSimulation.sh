#!/bin/bash -x

echo "WELCOME TO GAMBLING SIMULATION"

STAKE_PER_DAY=100
BET=1
MAX_STAKE=$(($STAKE_PER_DAY+(50*$STAKE_PER_DAY/100)))
MIN_STAKE=$(($STAKE_PER_DAY-(50*$STAKE_PER_DAY/100)))

#variables
cash=$STAKE_PER_DAY

function dailyPlay()
{
	while [ $cash -gt $MIN_STAKE ] && [ $cash -lt $MAX_STAKE ]
	do
		random=$((RANDOM%2))
		if [ $random == 1 ]
		then
			cash=$(($cash+$BET))
			echo $cash
		else
			cash=$(($cash-$BET))
			echo $cash
		fi
	done
	echo $cash
}
dailyPlay
