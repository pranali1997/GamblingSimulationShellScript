#!/bin/bash -x

echo "WELCOME TO GAMBLING SIMULATION"

#constants
STAKE_PER_DAY=100
BET=1
MAX_STAKE=$(($STAKE_PER_DAY+(50*$STAKE_PER_DAY/100)))
MIN_STAKE=$(($STAKE_PER_DAY-(50*$STAKE_PER_DAY/100)))
DAYS=20

#variables
cash=$STAKE_PER_DAY
gainAmount=0
totalProfit=0
stopGambling="false"

declare -A dayProfit
declare -A sumAmount

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

function profitForPerticularDay()
{
        local day=1
        while [ $day -lt $DAYS ]
        do
                local profitOfTheDay=0
                profitOfTheDay=$(dailyPlay)
                dayProfit["Day$day"]=$profitOfTheDay
                day=$(($day+1))
                totalProfit=$(($totalProfit+$profitOfTheDay))
		sumAmount["Day$day"]=$totalProfit
	done
	echo $totalProfit

}
profitForPerticularDay

function luckiestAndUnluckiestDay()
{
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

function stopGamblingOrNot()
{
	while [ $stopGambling == "false" ]
        do
		if [ $totalProfit -gt 0 ]
		then
			profit=$(profitForPerticularDay)
			echo $profit
			stopGamblingOrNot
        	fi
		if [ $totalProfit -le 0 ]
		then
			stopGambling="true"
                	echo "last month profit was nothing hence stoped gambling"
			break
		fi
	done
}
stopGamblingOrNot
