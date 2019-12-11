#!/bin/bash -x

echo "WELCOME TO GAMBLING SIMULATION"

STAKE_PER_DAY=100
BET=1

#variables
winOrLoss=$((RANDOM%2))

if [ winOrLoss -eq 1]
then
	echo "win"
else
	echo "loss"
fi
