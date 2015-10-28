#!/bin/bash
#this is master script, it call slave script for do work
#becouse of this, we don't need, when copy from remote PC is finish 
#for start next one copy, all copy is in backgraund
#list ofaddresses  !!!
list="192.168.0.12 192.168.0.13"
#user for connaction
user=$1
#what will be copy !!!
way=$2
#distination of backup files
dist=/home/mir/backup

for adr in $list
do
	/home/mir/slave.sh $adr $user $way $dist &
done
