#!/bin/bash
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
join sensors temp | awk '{print $2"\t"$3}' | sort -k2
