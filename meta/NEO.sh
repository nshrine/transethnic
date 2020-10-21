#!/bin/bash

for p in fev1 fvc fevfvcc; do
    for s in smk nonsmk; do
        ./filter.sh NEO <(zcat original_files_as_downloaded/NEO/NEO_lf${p}_${s}_chr{1..22}_TF_18032020.txt.gz | awk 'NR == 1 || $1 != "CHR"') \
            | gzip >| NEO/NEO_lf${p}_${s}_chr1_22_filtered.txt.gz
    done
done

for p in fev1 fvc fevfvcc; do
    for s in smk nonsmk; do
        ./filter.sh NEO <(zcat original_files_as_downloaded/NEO/NEO_lf${p}_${s}_chrX_TF_18032020.txt.gz | awk 'NR == 1 || $1 != "CHR"') \
            | gzip >| NEO/NEO_lf${p}_${s}_chrX_filtered.txt.gz
    done
done
