#!/bin/bash

MRMEGA=$1
BED=${MRMEGA}.bed
BED_NEW=${MRMEGA}.hg19.bed
OUT=$2

# MARKERNAME      EA      NEA     BETA    SE      EAF     N       CHROMOSOME      POSITION        PVALUE

zcat $MRMEGA | awk 'BEGIN {
    OFS = "\t"
}

NR > 1 {
    sub("23", "X", $1)
    print "chr"$8, $9, $9 + 1, $1
}' > $BED

liftOver $BED hg38ToHg19.over.chain $BED_NEW ${BED/.bed/.unmapped}

module load R

Rscript - <<-EOT
    library(data.table)
    hg38.dt <- fread("$MRMEGA")
    hg19.bed <- fread("$BED_NEW")
    setkey(hg38.dt, MARKERNAME)
    setkey(hg19.bed, V4)
    hg19.dt <- hg38.dt[ hg19.bed ]
    hg19.dt[, V1i:=as.integer(sub("chr", "", sub("chrX", "chr23", V1))) ]
    hg19.dt <- hg19.dt[ CHROMOSOME == V1i ]
    hg19.dt[, c("CHR", "POS", "Amin", "Amax") := tstrsplit(MARKERNAME, "_", type.convert=TRUE) ]
    hg19_out.dt <- hg19.dt[, .(MARKERNAME=paste(CHROMOSOME, V2, Amin, Amax, sep="_"), EA, NEA, BETA, SE, EAF, N, CHROMOSOME, POSITION=V2, PVALUE) ]
    hg19_out.dt <- hg19_out.dt[ order(CHROMOSOME, POSITION) ]
    fwrite(hg19_out.dt, "$OUT", sep="\\t")
EOT
