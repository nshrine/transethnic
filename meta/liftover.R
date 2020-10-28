sink(stderr())

suppressMessages(library(tidyverse))
suppressMessages(library(rtracklayer))
suppressMessages(library(GenomicRanges))

chain <- import.chain("hg38ToHg19.over.chain")

results <- read_tsv(file("stdin"))
orig_names <- names(results)
idcol <- names(results) %>% grep("MarkerName|unique_id", ., value=TRUE) %>%
    sym

dups <- results %>%
    filter(duplicated(!!idcol)) %>%
    pull(!!idcol)

results <- results %>%
    filter(!(!!idcol %in% dups)) %>%
    select(-starts_with("chr")) %>%
    separate(!!idcol, c("CHR", "BP", "Amin", "Amax"))

results_hg19 <- results %>%
    mutate(CHR=paste0("chr", CHR)) %>%
    makeGRangesFromDataFrame(seqnames="CHR", start.field="BP", end.field="BP", keep=TRUE) %>%
    liftOver(chain) %>% as.data.frame %>% as_tibble %>%
    mutate(CHR = seqnames %>% as.character %>% sub("^chr", "", .),
           BP = start,
           !!idcol := paste(CHR, BP, Amin, Amax, sep="_")) %>%
    rename_at(vars(contains("P.value")), ~"P-value")

new_names <- intersect(orig_names, names(results_hg19))
results_hg19 <- results_hg19 %>% select(all_of(new_names))
    
sink()
write.table(results_hg19, "", row.names=F, quote=F, sep="\t")
