library(tidyverse)

pheno <- "FF"
snp <- "rs13141641"

results <- tibble(study=scan("FF.studies", character())) %>%
    group_by(study) %>%
    do(paste(.$study, pheno, snp, sep="_") %>% paste0(".txt") %>%
       read_tsv(col_types=cols(effectallele="c", otherallele="c"))) %>%
    ungroup %>%
    mutate_at(vars(ends_with("allele")), toupper)
