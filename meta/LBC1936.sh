#!/bin/bash

for p in FEV1 FVC FF PEF; do
    for s in smk nonsmk; do
        ./filter.sh LBC1936 <(zcat original_files_as_downloaded/LBC1936/LBC1936_${p}_${s}_chr{1..22}_SEH_28112019.out.gz  | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
        | gzip >| LBC1936/LBC1936_${p}_${s}_chr1_22_filtered.txt.gz
    done
done
