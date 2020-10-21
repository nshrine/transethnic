#!/bin/bash

PHENO=$1
CHR=$2

awk 'NR > 1 { print $1 }' ../${PHENO}_chr${CHR}_loci.txt | while read l; do
    cut -f 1 studies.txt | while read c; do
        make LOCUS=$l COHORT=$c CHR=$CHR
    done
done
