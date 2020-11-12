#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 PHENO CHR"
    exit 1
fi

PHENO=$1
CHR=$2
LOCI=../${PHENO}_chr${CHR}_loci.txt
n=$((`cat ${LOCI} | wc -l` - 1))

for i in `seq 1 $n`; do
    LOCUS=locus$i
    ROUND=`wc -l ${PHENO}_chr${CHR}_${LOCUS}_round*.cond | head -n -1 | awk '{ print $1 }' | sort | uniq -d`

    if [ $ROUND -gt 1 ]; then
        echo -n "Running ${PHENO} chr${CHR} ${LOCUS}, ${ROUND} signals: "
        qsub -v PHENO=${PHENO},CHR=${CHR},LOCUS=${LOCUS},ROUND=${ROUND} run_joint.sh
    else
        echo "${PHENO} chr${CHR} ${LOCUS} only 1 signal"
    fi
done
