#!/bin/bash

module load julia 

for p in FEV1 FVC FF PEF; do
    ./filter.sh VIKING <(zcat original_files_as_downloaded/VIKING/VIKING_${p}_all_chr{1..22}_kak_26052017.txt.gz | awk 'NR == 1 || $1 != "MarkerName"') | \
        ./addPvalue.jl VIKING | gzip >| VIKING/VIKING_${p}_all_chr1_22_filtered.txt.gz
done
