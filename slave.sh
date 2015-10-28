#!/bin/bash
#var for adress of remote PC
adr=$1
#User for connection - argument !!!
user=$2
#target, whot will copy - argument !!!
targetway=$3
#Login/adres remoute mechine
remote=$user@$adr
#year, mounth, day of when operation is start
name=$(date +%y%m%d)
#Were will be locate our backup
dist=$4/$adr/$name
#md5 sum of remoute file and what we have after copy
rsum=1	#on remote PC
hsum=2	#om main PC
#count, how much time we  will try to copy
count=0
while [[ "$rsum" != "$hsum" && "$count" < 3 ]]
do
	count=$(($count+1))
	rsh $remote tar cfP /home/$user/$name.tar -C $targetway .
	mkdir -p $dist
	timeout 5m scp $remote:/home/$user/$name.tar $dist
	rsum=$( rsh $remote md5sum $name.tar | cut -f1 -d' ' )
	hsum=$( md5sum $dist/$name.tar | cut -f1 -d' ' )
	if [[ "$rsum" = "$hsum" ]]
		then
			cd $dist
			tar xfP $name.tar
			echo " $adr/$targetway was copy successfully in $dist " >> $4/$adr/log
		else
			cd $dist
			echo " ATTENTION, it was error in copy file frome remote PC (mistake in md5 summ, maby copy was), if this like error is 3 time in row, so copy was unsuccesfull " >> $4/$adr/log
	fi
	rm -f $name.tar
	rsh $remote rm -f $name.tar
done
