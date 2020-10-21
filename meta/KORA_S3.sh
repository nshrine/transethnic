#!/bin/bash

for p in FEV1 FVC FF; do
    ./filter.sh KORA_S3 <(awk 'NR == 1 || FNR > 1' original_files_as_downloaded/KORA_S3/KORA_S3_${p}_chr_{1..22}_GC_adjusted_METAL_input.txt | \
        tr ':' ' ' | awk 'NR == 1 { print "CHR", "BP", $2, $3, $4, $5, $6, $7, $8 } NR > 1 { print $1, $2, $5, $6, $7, $8, $9, $10, $11 }') | \
        gzip >| KORA_S3/KORA_S3_${p}_chr_1_22_GC_adjusted_filtered.txt.gz &
done
