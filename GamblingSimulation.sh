#!/bin/bash -x

echo "WELCOME TO GAMBLING SIMULATION"

#constants
STAKE_PER_DAY=100
BET=1
MAX_STAKE=$(($STAKE_PER_DAY+(50*$STAKE_PER_DAY/100)))
MIN_STAKE=$(($STAKE_PER_DAY-(50*$STAKE_PER_DAY/100)))
DAYS=20

#variables
gainAmount=0

declare -A dayProfit
declare -A sumAmount

function getDailyPlay()
{
	cash=$STAKE_PER_DAY
	while [ $cash -gt $MIN_STAKE ] && [ $cash -lt $MAX_STAKE ]
	do
		if [ $((RANDOM%2)) == 1 ]
		then
			cash=$(($cash+$BET))
		else
			cash=$(($cash-$BET))
		fi
	done

	gainAmount=$(($cash-$STAKE_PER_DAY))
	echo $gainAmount
}


function getProfitForPerticularDay()
{
        local day=1
	totalProfit=0
        while [ $day -lt $DAYS ]
        do
                local profitOfTheDay=0
                profitOfTheDay=$(getDailyPlay)
                dayProfit["Day$day"]=$profitOfTheDay
                day=$(($day+1))
                totalProfit=$(($totalProfit+$profitOfTheDay))
		sumAmount["Day$day"]=$totalProfit
	done
	echo 	 $totalProfit
}

function getUnluckiestDay()
{

	for d in "${!sumAmount[@]}"
	do
		echo "day$d" ${sumAmount[$d]}
	done | sort -k3 -nr | head -1

}

function getLuckiestDay()
{

	for d in "${!sumAmount[@]}"
	do
		echo "day$d" ${sumAmount[$d]}
	done | sort -k3 -nr | tail -1

}

function getStopGamblingOrNot()
{
		echo $profit
		if [ $totalProfit -gt 0 ]
		then
			getProfitForPerticularDay
			getStopGamblingOrNot
		fi

}

function main()
{
	getProfitForPerticularDay
	getStopGamblingOrNot
	getUnluckiestDay
	getLuckiestDay
}
main
