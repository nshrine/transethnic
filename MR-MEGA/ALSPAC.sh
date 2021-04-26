#!/bin/bash

for i in fev1 fvc pef; do
    ./filter.sh ALSPAC <(zcat original_files_as_downloaded/ALSPAC/ALSPAC_${i}f8res_all_chr{1..22}_rg_14102020.gz | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
        | gzip >| ALSPAC/ALSPAC_${i}_all_chr1_22_filtered.txt.gz &
done

./filter.sh ALSPAC <(zcat original_files_as_downloaded/ALSPAC/ratiof8res_chr{1..22}.gz | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
            | gzip >| ALSPAC/ALSPAC_ratio_all_chr1_22_filtered.txt.gz &

for i in original_files_as_downloaded/ALSPAC/*_chrX_rg_14102020.gz; do
    ./filter.sh ALSPAC <(zcat $i | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
        | gzip >| ALSPAC/`basename ${i/rg_14102020/filtered}` &
done
