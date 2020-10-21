#!/bin/bash

BASE=/scratch/gen1/agib1/trans-ethnic/raw/big_METAL
PHENO=FF
SNP=rs13141641

grep PROCESS ${BASE}/${PHENO}_big_METAL.txt | cut -d '/' -f  6- | sed 's%^%/scratch/gen1/agib1/%' | while read f; do
    zcat $f | awk 'NR == 1 { print }; $0 ~ /'${SNP}'_/ { print; exit }' > `basename $f | sed 's/_all_filtered_rsid.txt.gz//'`_${SNP}.txt
done
