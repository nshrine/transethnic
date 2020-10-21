#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 PHENO CHR"
    exit 1
fi

PHENO=$1
CHR=$2

awk 'NR > 1 { print $1 }' ../${PHENO}_chr${CHR}_loci.txt | while read l; do
    echo -en "${l}\t"
    cat `ls ${PHENO}_chr${CHR}_${l}_round?.cond | sort | tail -1` | tr '\n' '\t'
    echo
done
