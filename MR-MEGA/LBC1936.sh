#!/bin/bash

# LBC1936_FEV1_nonsmk_chr7_SEH_01092020.out

for p in FEV1 FVC FF PEF; do
    for s in smk nonsmk; do
        ./filter.sh LBC1936 <(zcat original_files_as_downloaded/LBC1936/LBC1936_${p}_${s}_chr{1..22}_SEH_01092020.out.gz  | grep -v "^#" | awk 'NR == 1 || $1 !~ /alternate/' | ./snptestfreq.awk) \
        | gzip >| LBC1936/LBC1936_${p}_${s}_chr1_22_filtered.txt.gz
    done
done
