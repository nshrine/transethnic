library(tidyverse)

signals <- read_tsv("TEmeta_signals.txt")

conditional <- signals %>% 
    group_by(locus, trait) %>%
    filter(n() > 1) %>%
    mutate(condition_on=map_chr(sentinel, ~{
        sentinel[ sentinel != .] %>%
            paste(collapse=",")
    })) %>%
    select(trait, locus, sentinel, start, end, condition_on)

write_tsv(conditional, "conditional.txt")
