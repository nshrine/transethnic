#!/bin/bash

for p in FEV1 FVC FF PEF; do
    for s in smk nonsmk; do
        ./filter.sh SHIP-TREND-0 <(zcat original_files_as_downloaded/SHIP-TREND-0/SHIP-TREND-0_${p}_${s}_CHR{1..22}_SW_21012020.gz | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
            | gzip >| SHIP-TREND-0/SHIP-TREND-0_${p}_${s}_CHR1_22_filtered.txt.gz
    done
done

for i in original_files_as_downloaded/SHIP-TREND-0/SHIP-TREND-0*CHRX*.gz; do
    ./filter.sh SHIP-TREND-0 <(zcat $i | grep -v "^#" | ./snptestfreq.awk) | gzip > SHIP-TREND-0/`basename ${i/SW_21012020/filtered}`
done
