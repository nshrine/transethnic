#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 PHENO ROUND"
    exit 1
fi

PHENO=$1
ROUND=$2

for CHR in {1..22}; do
    LOCI=../${PHENO}_chr${CHR}_loci.txt
    n=$((`cat ${LOCI} | wc -l` - 1))

    for i in `seq 1 $n`; do
        STEM=${PHENO}_chr${CHR}_locus${i}
        COND=${STEM}_round${ROUND}.cond
        META=${STEM}_round${ROUND}_1.tbl
        OUT="$PHENO $CHR locus$i $ROUND"
        finished=false
        
        if [ $ROUND -gt 1 ]; then
            for i in `seq 2 ${ROUND}`; do
                PREV_COND=${STEM}_round$((i - 1)).cond
                THIS_COND=${STEM}_round${i}.cond
                [ -s ${PREV_COND} ] && [ -s ${THIS_COND} ] &&
                    [ `wc -l < ${PREV_COND}` -eq `wc -l < ${THIS_COND}` ] &&
                    finished=true && break
            done
        fi

        if ! $finished; then
            if [ -s $COND ]; then
                [ `wc -l < $COND` -eq $ROUND ] && [ ! -s $META ] && echo $OUT
            else
                echo "$OUT not run yet"
            fi
        fi
    done
done
