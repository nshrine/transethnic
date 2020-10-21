#!/bin/bash

module load julia 

for p in FEV1 FVC FEV1pFVC; do
    for s in smk nonsmk; do
        ./filter.sh NFBC66 <(zcat original_files_as_downloaded/NFBC66/NFBC66_${p}_${s}_chr{1..22}_MW_20170505.txt.gz | awk 'NR == 1 || $1 != "MarkerName"') \
            | ./addPvalue.jl NFBC66 | gzip >| NFBC66/NFBC66_${p}_${s}_chr1_22_filtered.txt.gz
    done
done

for i in original_files_as_downloaded/NFBC66/*chrX*.txt.gz; do
    ./filter.sh NFBC66 <(zcat $i) | ./addPvalue.jl NFBC66 | gzip >| NFBC66/`basename ${i/MW_20170505/filtered}`
done
