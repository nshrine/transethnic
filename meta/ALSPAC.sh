#!/bin/bash

for i in fev1 fvc ratio pef; do
    ./filter.sh ALSPAC <(zcat original_files_as_downloaded/ALSPAC/ALSPAC_z${i}_all_chr{1..22}_rg_18072019.gz | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
        | gzip >| ALSPAC/ALSPAC_z${i}_all_chr1_22_filtered.txt.gz &
done

for i in original_files_as_downloaded/ALSPAC/ALSPAC_z*_*males_chrX_rg_02082019.gz; do
    ./filter.sh ALSPAC <(zcat $i | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
        | gzip >| ALSPAC/`basename ${i/rg_02082019/filtered}` &
done
