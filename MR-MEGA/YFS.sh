#!/bin/bash

#MARKER ALLELE1 ALLELE2 N FREQ EFFECT STDERR PVALUE
#10 100000625 A G A G 418.8743 0.411855131264916 -0.0584692084227389 0.0713239873195385 0.412347689231155

for p in FEV1 FVC FF; do
    ./filter.sh YFS <(zcat original_files_as_downloaded/YFS/YFS_${p}_untransformed_chr_1_22_GC_adjusted_METAL_input.txt | awk 'NR == 1 || FNR > 1' | \
        tr ':' ' ' | awk 'NR == 1 { print "CHR", "BP", $2, $3, $4, $5, $6, $7, $8 } NR > 1 { print $1, $2, $5, $6, $7, $8, $9, $10, $11 }') | \
        gzip >| YFS/YFS_${p}_untransformed_chr_1_22_GC_adjusted_filtered.txt.gz &
done
