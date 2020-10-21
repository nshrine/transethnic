#!/usr/bin/awk -f

#MarkerName=$1
#Allele1=$2
#Allele2=$3
#Freq1=$4
#FreqSE=$5
#Weight=$6
#Zscore=$7
#P-value=$8
#Direction=$9

BEGIN { 
    OFS = "\t"
}

NR == 1 {
    print "unique_id", "MAF", "MAC", "N", "Zscore", "P"
    next
}

{
    id=$1
    freq=$4
    N=$6
    Z=$7
    P=$8

    maf = freq < 0.5 ? freq : 1 - freq
    mac = maf * 2 * N
}

P < 0.01 && mac >= 20 {
    print id, maf, mac, N, Z, P
}
