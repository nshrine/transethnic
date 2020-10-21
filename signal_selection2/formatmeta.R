sink(stderr())

library(data.table)

args <- commandArgs(T)
results_file <- args[1]

results.dt <- fread(results_file)
results.dt[, MarkerName:=sub("^X", 23, MarkerName) ]
results.dt[, CHR:=as.integer(sub("_.+", "", MarkerName)) ]
results.dt[, BP:=as.integer(sub("^[1-9][0-9]?_([1-9][0-9]+)_[ATCG_]+$", "\\1", MarkerName)) ]
results.dt[, MAF:=ifelse(Freq1 <= 0.5, Freq1, 1-Freq1) ]
results.dt[, MAC:=round(MAF*2*Weight, 1) ]
results.dt <- results.dt[, .(`#ID`=MarkerName, CHR, BP, Allele1, Allele2, Freq1, MAF, MAC, Weight, Zscore, P=`P-value`) ]
results.dt <- results.dt[ order(CHR, BP) ]

sink()
fwrite(results.dt, "", quote=F, sep="\t", na="NA")
