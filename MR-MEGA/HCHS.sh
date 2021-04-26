#!/bin/bash

for i in FEV1 FVC FF; do
    ./filter.sh HCHS <(zcat original_files_as_downloaded/HCHS/HCHS_${i}_all_CHR{1..22}_JWL_*.txt.gz | awk 'NR == 1 || $1 != "chr"') \
        | gzip >| HCHS/HCHS_${i}_all_CHR1_22_filtered.txt.gz
done
