#!/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage: $0 PHENO CHR ROUND"
    exit 1
fi

PHENO=$1
CHR=$2
ROUND=$3
PREV_ROUND=$((ROUND - 1))
LOCI=../${PHENO}_chr${CHR}_loci.txt
n=$((`cat ${LOCI} | wc -l` - 1))

if [ $ROUND -eq 1 ]; then
    qsub -v PHENO=${PHENO},CHR=${CHR},ROUND=${ROUND} -t 1-$n -N ${PHENO}_chr${CHR}_round${ROUND} run_conditional.sh
else
    for i in `seq 1 $n`; do
        if [ -s ${PHENO}_chr${CHR}_locus${i}_round${PREV_ROUND}_1.tbl ]; then
            make cond PHENO=$PHENO CHR=$CHR ROUND=$ROUND LOCUS=locus$i
            if [ `cat ${PHENO}_chr${CHR}_locus${i}_round${ROUND}.cond | wc -l` -eq $ROUND ]; then
                echo "Running locus$i"
                qsub -v PHENO=${PHENO},CHR=${CHR},ROUND=${ROUND} -t $i -N ${PHENO}_chr${CHR}_round${ROUND} run_conditional.sh
            else
                echo "Skipping locus$i"
            fi
        else
            echo "Skipping locus$i"
        fi
    done
fi
