#!/bin/bash

METAL=$1
BED=${METAL}.bed
BED_NEW=${METAL}.hg19.bed
OUT=$2


cat $METAL | awk 'BEGIN {
    OFS = "\t"
}

NR > 1 {
    sub("23", "X", $1)
    print "chr"$1, $2, $2 + 1, $3
}' > $BED

liftOver $BED hg38ToHg19.over.chain $BED_NEW ${BED/.bed/.unmapped}

module load R

Rscript - <<-EOT
    library(data.table)
    hg38.dt <- fread("$METAL")
    hg19.bed <- fread("$BED_NEW")
    setkey(hg38.dt, MarkerName)
    setkey(hg19.bed, V4)
    hg19.dt <- hg38.dt[ hg19.bed ]
    hg19.dt[, V1i:=as.integer(sub("chr", "", sub("chrX", "chr23", V1))) ]
    hg19.dt <- hg19.dt[ Chromosome == V1i ]
    hg19.dt[, c("CHR", "POS", "Amin", "Amax") := tstrsplit(MarkerName, "_", type.convert=TRUE) ]
    hg19_out.dt <- hg19.dt[, .(Chromosome, Position=V2, MarkerName=paste(Chromosome, V2, Amin, Amax, sep="_"), Allele1, Allele2, Freq1, FreqSE, Effect, StdErr, \`P-value\`, Direction, TotalN) ]
    hg19_out.dt <- hg19_out.dt[ order(Chromosome, Position) ]
    fwrite(hg19_out.dt, "$OUT", sep="\\t")
EOT
