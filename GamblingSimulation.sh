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

function profitOfParticularDays()
{
        local day=1
        while [ $day -lt $DAYS ]
        do
                local profitOfTheDay=0
                profitOfTheDay=$(dailyPlay)
                dayProfit[$day]=$gainAmount
                day=$(($day+1))
                totalProfit=$(($totalProfit+$profitOfTheDay))
        done
        echo "total profit :"$totalProfit
}
profitOfParticularDays



