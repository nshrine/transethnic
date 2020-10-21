#!/bin/bash

DESC=`dirname $0`/descriptives_cols.tsv
STUDY=$1
OUT=$2
shift 2

read study Software Build SNPID Chromosome Position effectallele otherallele EAF beta se P N INFO < \
    <(awk '$1 == "'${STUDY}'"' ${DESC})

[ $P = "NA" ] && P=P

echo "AVERAGEFREQ ON
SCHEME SAMPLESIZE

MARKER unique_id
ALLELE $effectallele $otherallele
WEIGHT $N
EFFECT $beta
PVALUE $P
FREQ $EAF
"

for i in $*; do
    echo "PROCESS $i"
done

echo "
OUTFILE ${OUT}_ .tbl
ANALYZE"
