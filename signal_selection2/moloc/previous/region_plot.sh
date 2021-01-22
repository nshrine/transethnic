#!/bin/sh

module load python/intel/27

#export PATH=${PATH}:/data/gen1/reference/locuszoom_1.3/bin
export PATH=${PATH}:/data/gen1/reference/locuszoom-standalone/bin

#if [ $# -lt 8 ]; then
#    echo "Usage: $0 RESULTS.epacts.gz OUTPUT_PREFIX LD CHR START END SNP SUGGESTIVE HISTART HIEND [ MARKERS ]"
#    exit 1
#fi

EPACTS=$1
PREFIX=$2
#LD=$3
DB=/data/gen1/AIRPROM/assoc/region_plots/UK10K+1000G_Phase3.db
CHR=$3
START=$4
END=$5
SNP=$6
#SUGGESTIVE=$8
#HISTART=$9
#HIEND=${10}
TITLE=$7
ARGS="--epacts $EPACTS --chr $CHR --start $START --end $END --refsnp $SNP --prefix $PREFIX --build hg19 --pop EUR --build hg19 --source 1000G_March2012 --db $DB --plotonly --no-date"
[ $# -gt 7 ] && ARGS="$ARGS --denote-markers-file $8"

locuszoom $ARGS \
    ymax=4 \
    ldcuts="0,.1,.5,.8,1" \
    ldColors="white,gray50,yellow,orange,red,blue" \
    recombColor=lightskyblue \
    signifLine="8.3" \
    signifLineColor="red" \
    rfrows=8 \
    geneFontSize=.7 \
    showPartialGenes=TRUE \
    refsnpTextSize=0.7 \
    hiColor=green \
    hiAlpha=0.4 \
    title=${TITLE}
#    legend='none' \
#    width=7 height=7 \
#    showAnnot=FALSE \
#    hiStart=$HISTART \
#    hiEnd=$HIEND \
#    annotCol='ANNOT' \
#    annotPch='1,21' \
