#!/bin/bash

for p in FEV1 FVC FF; do
    for s in ever never; do
        ./filter.sh UKHLS <(zcat original_files_as_downloaded/UKHLS/${p}.${s}_CHR{1..22}_CHUNK*.snptest.gz | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
            | gzip >| UKHLS/${p}.${s}_CHR1_22_filtered.txt.gz
    done
done
