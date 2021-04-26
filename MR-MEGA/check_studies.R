library(tidyverse)

FHS_CHRX_provided <- read_csv(
    "original_files_as_downloaded/FHS/lme2v.FHS_FEV1_all_CHRX_all_EL_09172020.summary.csv.gz")
FHS_CHRX_meta <- read_tsv("FHS/FHS_FEV1_untransformed_CHRX_1.tbl")

FHS_CHRX_provided <- FHS_CHRX_provided %>%
    mutate(MarkerName = paste(Chromosome, Phys_location,
                              pmin(effect, noneffect), pmax(effect, noneffect), sep = "_"))

FHS_CHRX_meta <- FHS_CHRX_meta %>%
    mutate(across(starts_with("Allele"), toupper))

FHS_comp <- inner_join(FHS_CHRX_meta, FHS_CHRX_provided) %>%
    mutate(beta.cor = ifelse(Allele1 == effect, beta, -beta))

ggplot(FHS_comp, aes(x=Effect, y=beta.cor)) +
    geom_point() +
    geom_abline(slope=1, intercept=0, linetype=2) +
    geom_smooth(method = "lm")

ggplot(FHS_comp, aes(x=Effect, y=beta.cor)) +
    geom_point() +
    geom_abline(slope=1, intercept=0, linetype=2) +
    geom_smooth(method = "lm")