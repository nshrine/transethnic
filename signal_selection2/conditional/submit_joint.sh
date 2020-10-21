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
    r=1

    while [ -s ${PHENO}_chr${CHR}_${LOCUS}_round${r}.cond ] && [ `cat ${PHENO}_chr${CHR}_${LOCUS}_round${r}.cond | wc -l` -eq $r ]; do
        ROUND=$r
        let r=$((r + 1))
    done

    if [ $ROUND -gt 1 ]; then
        echo -n "Running ${PHENO} chr${CHR} ${LOCUS}, ${ROUND} signals: "
        qsub -v PHENO=${PHENO},CHR=${CHR},LOCUS=${LOCUS},ROUND=${ROUND} run_joint.sh
    else
        echo "${PHENO} chr${CHR} ${LOCUS} only 1 signal"
    fi
done
