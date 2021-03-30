suppressMessages(library(tidyverse))
suppressMessages(library(GenomicRanges))
suppressMessages(library(rtracklayer))

args <- commandArgs(T)
argc <- length(args)

infile <- ifelse(argc > 0, args[1], "/data/ukb/exomes/23155/UKBexomeOQFE_chr22.bim")
chain <- import.chain("hg38ToHg19.over.chain")

hg38.bim <- read_tsv(infile, col_names = c("chr", "snp", "cm", "start", "a1", "a2")) 

hg19.bim <- hg38.bim %>%
    mutate(chr=paste0("chr", ifelse(chr == 23, "X", chr))) %>%
    makeGRangesFromDataFrame(end.field = "start", keep=TRUE) %>%
    liftOver(chain) %>%
    as.data.frame %>%
    as_tibble %>%
    mutate(chr=sub("chr", "", ifelse(seqnames == "chrX", "chr23", seqnames)) %>% as.integer,
           chr.hg38=sub(":.+", "", snp) %>% as.integer) %>%
    filter(chr == chr.hg38) %>%
    select(chr, snp, cm, start, a1, a2)

outfile <- basename(infile) %>%
    sub(".bim$", "_hg19.bim", .)

write.table(hg19.bim, outfile, row.names=F, col.names=F, quote=FALSE, sep="\t")
