library(tidyverse)
library(scales)

array.bim <- read_tsv("array_not_gwas_samp.bim", col_names=F) %>%
    select(SNP=X2, pos=X4)

array.frq <- data.table::fread("array_not_gwas_samp_freq.frq") %>%
    as_tibble %>%
    mutate(MAF=ifelse(is.na(MAF), 0, MAF))

array.cnt <- data.table::fread("array_not_gwas_samp_freq.frq.count") %>%
    as_tibble %>%
    inner_join(array.frq) %>%
    inner_join(array.bim) %>%
    mutate(Amin=pmin(A1), Amax=pmax(A2))

wes.bim <- read_tsv("array_wes_samp.bim", col_names=F) %>%
    select(SNP=X2, pos=X4)

wes.frq <- data.table::fread("array_wes_samp.freq.frq") %>%
    as_tibble %>%
    mutate(MAF=ifelse(is.na(MAF), 0, MAF))
    
wes.cnt <- data.table::fread("array_wes_samp.freq.frq.count") %>%
    as_tibble %>%
    inner_join(wes.frq) %>%
    inner_join(wes.bim) %>%
    mutate(Amin=pmin(A1), Amax=pmax(A2))

comp <- inner_join(wes.cnt, array.cnt, c("CHR", "pos", "Amin", "Amax"), suffix=c(".wes", ".array"))

ggplot(comp, aes(x=MAF.wes, y=MAF.array)) +
    geom_point() +
    geom_abline(slope=1, linetype=2, intercept=0) +
    geom_smooth(method="lm") +
    scale_x_log10() +
    scale_y_log10()

ggplot(comp %>% filter(C1.wes >= 3), aes(x=MAF.wes, y=MAF.array)) +
    geom_point() +
    geom_abline(slope=1, linetype=2, intercept=0) +
    geom_smooth(method="lm") +
    scale_x_log10(label=percent) +
    scale_y_log10(label=percent)

ggplot(comp %>% filter(MAF.wes >= 0.01), aes(x=MAF.wes, y=MAF.array)) +
    geom_point() +
    geom_abline(slope=1, linetype=2, intercept=0) +
    geom_smooth(method="lm") +
    scale_x_log10(label=percent) +
    scale_y_log10(label=percent)

array1000 <- data.table::fread("array1000_freq.frq") %>% as_tibble
wes1000 <- data.table::fread("wes1000_freq.frq") %>% as_tibble

comp1000 <- inner_join(wes1000, array1000, c("CHR", "SNP"), suffix=c(".wes", ".array"))

ggplot(comp1000, aes(x=MAF.wes, y=MAF.array)) +
    geom_point() +
    geom_abline(slope=1, linetype=2, intercept=0) +
    geom_smooth(method="lm") +
    scale_x_continuous(label=percent) +
    scale_y_continuous(label=percent)
