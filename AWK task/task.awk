#!/bin/bash
#index arrays = index sensor
#sum[i] - arithmetic sum of the sensor with index = i
#count[i] - counter sensors with index = i
awk '
BEGIN {
	FS ="/"
}
{
	count[$2]++
	sum[$2]=sum[$2]+$3
}
END {
	for (i=1; i<6; i++)
	{
		printf "%d %.0f\n",i,sum[i]/count[i]
	}
}
' readings >> temp
join sensors temp | awk '{print $2"\t"$3}' | sort -k2	#bringing to the required form
