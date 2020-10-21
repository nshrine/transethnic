#!/bin/bash

for p in FEV1 FVC FF; do
    for s in smk nonsmk; do
        ./filter.sh ARIC_EA <(zcat original_files_as_downloaded/ARIC_EA/ARIC_${p}_${s}_CHR{1..22}_mrb_10112019.txt.gz) | \
            gzip >| ARIC_EA/ARIC_${p}_${s}_CHR1_22_filtered.txt.gz
    done
done
