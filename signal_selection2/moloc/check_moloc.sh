#!/bin/bash

awk 'NR > 1 { print ($2 < 10 ? 0$2 : $2)":"$3"-"$3 }' signals_latest.txt > regions_latest.txt
split -l 200 regions_latest.txt

module load gcc plink

for i in {1..22}; do
    for j in x??; do
        bgenix -g /data/ukb/imputed_v3/ukb_imp_chr${i}_v3.bgen -incl-range $j > chr${i}_${j}.bgen
    done
done

plink2 --bgen signals_latest.bgen ref-first \
    --sample /data/gen1/UKBiobank/application_648/UKBiobank_500K/ukb648_imp_chr1_v3_s487371.sample \
    --make-bed --out tmp 

plink --bfile tmp --make-bed --out signals_latest

plink --bfile signals_latest --ld-window 1000000 --ld-window-kb 1000000 --ld-window-r2 0.8 --out signals_latest_LD --r2 yes-really
