library(data.table)
library(ggplot2)
library(scales)

source("ppv.R")

wes1000_freq.dt <- fread("wes1000_freq.frq")
array1000_freq.dt <- fread("array1000_freq.frq")
comp_freq.dt <- merge(wes1000_freq.dt, array1000_freq.dt, by="SNP", suffixes=c(".wes", ".array"))

ggplot(comp_freq.dt, aes(x=MAF.wes, y=MAF.array)) +
    geom_point() +
    geom_abline(slope=1, linetype=2, intercept=0) +
    scale_x_continuous(limits=c(0,0.5), label=percent) +
    scale_y_continuous(limits=c(0,0.5), label=percent)

roc_1000.dt <- get_roc("wes1000_A.raw", "array1000_A.raw")
roc_1000_freq.dt <- merge(roc_1000.dt, wes1000_freq.dt[, .(SNP, MAF)], by="SNP")

ggplot(roc_1000_freq.dt, aes(y=sensitivity, x=1-specificity)) +
    geom_point(aes(colour=log10(MAF))) +
    geom_abline(slope=1, intercept=0, linetype=2) +
    scale_x_continuous(limits=c(0,1), label=percent) +
    scale_y_continuous(limits=c(0,1), label=percent)
