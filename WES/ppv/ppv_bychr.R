source("ppv.R")

sink(stderr())

args <- commandArgs(T)

ppv.dt <- get_roc(args[1], args[2])

sink()
write.table(ppv.dt, "", row.names=F, quote=F, sep="\t")
