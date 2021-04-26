sink(stderr())
    
library(tidyverse)
library(furrr)

plan(multicore(workers=8))

pheno <- c("FEV1", "FVC", "FF", "PEF") %>%
    set_names

# MARKERNAME	EA	NEA	BETA	SE	EAF	N	CHROMOSOME	POSITION	PVALUE
get_stats <- function(pheno, cohort) {
    paste0("input_files/", pheno, "/", cohort, "_", pheno, ".txt.gz") %>%
        paste("zcat", ., "| cut -f 1,4-8") %>%
        data.table::fread(cmd=.) %>%
        mutate(MAF = ifelse(EAF > 0.5, 1-EAF, EAF),
               MAC = MAF * 2 * as.numeric(N)) %>%
        filter(MAC >= 10) %>%
        summarise(across(c(BETA, SE, EAF, MAF),
                         list(mean=mean, sd=sd, min=min, max=max), na.rm=T),
                  N=N[1])
}

get_pheno <- function(pheno) {
    paste0("check_dists_", pheno, ".txt") %>%
        scan(character()) %>%
        set_names %>%
        future_map_dfr(~get_stats(pheno, .x), .id="cohort")
}

results <- pheno %>%
    map_dfr(~get_pheno(.x), .id="pheno") %>%
    as_tibble

sink()
write.table(results, "", row.names=F, quote=F, sep="\t")
