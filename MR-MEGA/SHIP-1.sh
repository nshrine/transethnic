#!/bin/bash

for p in FEV1 FVC FF PEF; do
    for s in smk nonsmk; do
        ./filter.sh SHIP-1 <(zcat original_files_as_downloaded/SHIP-1/SHIP-1_${p}_${s}_CHR{1..22}_SW_21012020.gz | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
            | gzip >| SHIP-1/SHIP-1_${p}_${s}_CHR1_22_filtered.txt.gz
    done
done

for i in original_files_as_downloaded/SHIP-1/SHIP-1*CHRX*.gz; do
    ./filter.sh SHIP-1 <(zcat $i | grep -v "^#" | ./snptestfreq.awk) | gzip > SHIP-1/`basename ${i/SW_21012020/filtered}`
done
