#!/usr/bin/env Rscript

sink(stderr())
library(data.table)

args <- commandArgs(T)
s <- args[1]
infile <- args[2]

descriptives <- fread("descriptives_cols.tsv")
beta_col <- descriptives[ study == s, beta ]
se_col <- descriptives[ study == s, se ]

results <- fread(cmd=paste("zcat", infile))
results[, P:=2*pnorm(-abs(get(beta_col)/get(se_col)))]

sink()
write.table(format(results, digits=5), "", row.names=F, quote=F, sep="\t")
