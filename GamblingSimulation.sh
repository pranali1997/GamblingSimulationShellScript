#!/bin/bash -x

echo "WELCOME TO GAMBLING SIMULATION"

STAKE_PER_DAY=100
BET=1
MAX_STAKE=$(($STAKE_PER_DAY+(50*$STAKE_PER_DAY/100)))
MIN_STAKE=$(($STAKE_PER_DAY-(50*$STAKE_PER_DAY/100)))
DAYS=20

#variables
cash=$STAKE_PER_DAY
gainAmount=0
totalProfit=0

declare -A dayProfit
declare -A sunAmount

function dailyPlay()
{
	while [ $cash -gt $MIN_STAKE ] && [ $cash -lt $MAX_STAKE ]
	do
		random=$((RANDOM%2))
		if [ $random == 1 ]
		then
			cash=$(($cash+$BET))
		else
			cash=$(($cash-$BET))
		fi
	done

	gainAmount=$(($cash-100))
	echo $gainAmount
}

function luckiestAndUnluckiestDay()
{
        local day=1
        while [ $day -lt $DAYS ]
        do
                local profitOfTheDay=0
                profitOfTheDay=$(dailyPlay)
                dayProfit[$day]=$profitOfTheDay
                day=$(($day+1))
                totalProfit=$(($totalProfit+$profitOfTheDay))
		sumAmount[$day]=$totalProfit
	done
	echo "for luckiest day"
        for d in "${!sumAmount[@]}"
        do
                echo $d : ${sumAmount[$d]}
        done | sort -rn -k3 | head  -1

        echo "for unluckiest day"
        for d in "${!sumAmount[@]}"
        do
                echo $d : ${sumAmount[$d]}
        done | sort -n -k3 | head  -1

}
luckiestAndUnluckiestDay



