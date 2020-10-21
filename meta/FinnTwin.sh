#!/bin/bash

for i in FEV1 FVC FF PEF; do
    ./filter.sh FinnTwin <(zcat original_files_as_downloaded/FinnTwin/FinnTwin_${i}_all_CHR{1..22}_TP_15082019.txt.gz | awk 'NR == 1 || $1 != "CHROM"') \
        | gzip >| FinnTwin/FinnTwin_${i}_all_CHR1_22_filtered.txt.gz &
done

for i in original_files_as_downloaded/FinnTwin/FinnTwin_*_all_CHRX_all*; do
    ./filter.sh FinnTwin <(zcat $i) | gzip > FinnTwin/`basename ${i/TP_15082019/filtered}` &
done
