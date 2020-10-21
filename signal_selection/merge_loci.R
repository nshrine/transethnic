sink(stderr())

suppressMessages(library(GenomicRanges))
suppressMessages(library(tidyverse))

args <- commandArgs(T)
argc <- length(args)

sentinels_file <- ifelse(argc > 0, args[1], "fev1_sentinels_5e-9.txt")
width <- ifelse(argc > 1, args[2] %>% as.integer, 1e6)
gap <- ifelse(argc > 2, args[3] %>% as.integer, 5e5)

sentinels <- read_tsv(sentinels_file) %>%
    arrange(chrom, pos) %>%
    mutate(idx=1:n(), start=pos - width, end=pos + width)

sentinels.overlaps <- makeGRangesFromDataFrame(sentinels) %>%
    findOverlaps(maxgap = gap) %>%
    as_tibble %>%
    filter(queryHits != subjectHits) %>%
    mutate(hash=queryHits^2 * subjectHits^2) %>%
    group_by(hash) %>%
    slice(1) %>%
    ungroup %>%
    mutate(merge1=sentinels %>% slice(queryHits) %>% pull(rsid),
           merge2=sentinels %>% slice(subjectHits) %>% pull(rsid)) %>%
    select(merge1, merge2)

sentinels <- left_join(sentinels, sentinels.overlaps, c("rsid" = "merge1"))

sentinels <- sentinels %>%
    mutate(ismerge=ifelse(!is.na(merge2),1,0),
           diffmerge=c(0,diff(ismerge)),
           newlocus=ifelse(ismerge == diffmerge, 1, 0),
           locus=paste0("locus", cumsum(newlocus)))

loci <- sentinels %>%
    mutate(merge2=ifelse(is.na(merge2), "", merge2)) %>%
    group_by(locus) %>%
    summarise(first=first(rsid),
              merge.list=unique(merge2) %>% paste(collapse=" ") %>% str_trim)

sink()
write.table(loci, "", row.names = F, sep = "\t", quote=F)
