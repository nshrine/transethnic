library(data.table)
library(GenomicRanges)

signals.dt <- fread("signals.txt")
exomes.dt <- fread("UKBexomeOQFE.pos.gz")

signals.GRanges <- makeGRangesFromDataFrame(signals.dt, seqnames="V2",
                                            start.field="V3", end.field="V3",
                                            keep.extra.columns=TRUE)

exomes.GRanges <- makeGRangesFromDataFrame(exomes.dt, seqnames="V1",
                                           start.field="V2", end.field="V2")
