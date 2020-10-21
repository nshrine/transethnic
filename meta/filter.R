sink(stderr)
library(tidyverse)

args <- commandArgs(T)
s <- args[1]
infile <- args[2]

desc <- read_tsv("descriptives_corrected.tsv") %>%
    filter(study == s)

eaf_col <- sym(desc$EAF)
n_col <- sym(desc$N)
info_col <- sym(desc$INFO)

results <- read_table2(infile)
orig_names <- names(results)

results <- results %>%
    mutate(MAC = !!eaf_col * 2 * !!n_col)
