#!/bin/bash

for i in FEV1 FVC FF; do
    ./filter.sh BHS <(zcat original_files_as_downloaded/BHS/BHS_${i}_all_CHR{1..22}_BHM_13102019.txt.gz | awk 'NR == 1 || $1 != "chr"') \
        | gzip >| BHS/BHS_${i}_all_CHR1_22_filtered.txt.gz &
done
