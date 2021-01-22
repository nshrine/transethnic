sink(stderr())

suppressMessages(library(tidyverse))

args <- commandArgs(T)
infile <- args[1]

annot <- read_tsv(infile, col_names=c("Location", "Genes", "chr", "pos", "pos2", "a1", "a2", "id"), col_type=cols()) %>%
    select(-pos2) %>%
    mutate(idx = 1:n())

intergenic <- annot %>%
    filter(Location == "intergenic" | grepl("stream", Location))

genic <- annot %>% 
    anti_join(intergenic, "id") %>%
    mutate(Gene=sub("\\(NM.+", "", Genes), dist = 0) %>%
    select(Gene, Location, dist, Genes, id, chr, pos, idx)

nearest <- intergenic %>%
    mutate(Genes = sub(";", ",", Genes)) %>%
    separate(Genes, c("g1", "g2"), ",", fill="right", remove=FALSE) %>%
    pivot_longer(cols=c("g1", "g2")) %>%
    mutate(value = sub("\\(dist=", ",", value),
           value = sub(")", "", value)) %>%
    drop_na %>%
    filter(value != "NONE,NONE") %>%
    separate(value, c("Gene", "dist"), ",", fill="right", convert=TRUE) %>%
    mutate(dist = ifelse(is.na(dist), 0, dist)) %>%
    arrange(dist) %>%
    group_by(id) %>%
    slice(1) %>%
    ungroup %>%
    select(Gene, Location, dist, Genes, id, chr, pos, idx)

result <- bind_rows(genic, nearest) %>%
    arrange(idx) %>%
    select(-idx)

sink()
write.table(result, "", row.name=F, quote=F, sep="\t")
