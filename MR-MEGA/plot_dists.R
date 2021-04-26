library(tidyverse)

results <- read_tsv("check_dists_results_MAC10.txt")
results_long <- pivot_longer(results, 3:14)
ggplot(results_long, aes(x=value)) +
    geom_histogram() +
    facet_grid(name ~ pheno, scales="free")

ggplot(results, aes(x=cohort, y=BETA_sd)) +
    geom_bar(stat="identity") +
    facet_wrap(~pheno, ncol = 1, scales="free_y") +
    theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))

ggplot(results, aes(x=MAF_mean, y=BETA_sd)) +
    geom_point() +
    geom_smooth(method="lm") +
    facet_wrap(~pheno, scales="free")

get_update <- function(cohort, pheno) {
    pheno %>%
        map_dfr(~get_stats(.x, cohort), .id = "pheno") %>%
        add_column(cohort=cohort, .after="pheno")
}

cohorts_update <- c("MESA_CAU", "FinnTwin", "SHIP-1", "SHIP-TREND-0", "SHIP-TREND-0_B2")

updates <- cohorts_update %>%
    set_names %>%
    map_dfr(get_update)

results_updated <- results %>%
    filter(!cohort %in% cohorts_update) %>%
    bind_rows(updates)

cohorts_update2 <- c("FHS")
pheno2 <- c("FEV1", "FVC", "FF") %>% set_names

updates2 <- cohorts_update2 %>%
    set_names %>%
    map_dfr(~get_update(.x, pheno2))

results_updated2 <- results_updated %>%
    filter(!(cohort %in% cohorts_update2 & pheno %in% pheno2)) %>%
    bind_rows(updates2)

cohorts_update3 <- c("Korcula", "Split")
pheno3 <- c("PEF") %>% set_names

updates3 <- cohorts_update3 %>%
    set_names %>%
    map_dfr(~get_update(.x, pheno3))

results_updated3 <- results_updated2 %>%
    filter(!(cohort %in% cohorts_update3 & pheno %in% pheno3)) %>%
    bind_rows(updates3)

ggplot(results_updated3, aes(x=cohort, y=BETA_sd)) +
    geom_bar(stat="identity") +
    facet_wrap(~pheno, ncol = 1, scales="free_y") +
    theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))

ggplot(results_updated3, aes(x=BETA_sd)) + geom_histogram()

ggplot(results_updated3, aes(x=cohort, y=SE_sd)) +
    geom_bar(stat="identity") +
    facet_wrap(~pheno, ncol = 1, scales="free_y") +
    theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))


