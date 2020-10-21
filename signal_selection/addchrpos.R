sink(stderr())

library(data.table)

args <- commandArgs(T)
results_file <- args[1]
mapping_file <- "homo_sapiens.txt.gz"
ukb_file <- "ukb_mapping.gz"

results.dt <- fread(cmd=paste("zcat", results_file))
results.dt[, `:=`(Amin=pmin(Allele1, Allele2), Amax=pmax(Allele1, Allele2)) ]
results.dt[ grepl("^rs", MarkerName), rsid:=sub("_.+", "", MarkerName) ]
setkey(results.dt, rsid, Amin, Amax)
results.dt <- results.dt[ !duplicated(rsid) ]

rsid_map.dt <- fread(cmd=paste("zcat", mapping_file))
rsid_map.dt <- rsid_map.dt[, .(rsid=ID, CHR=`#CHROM`, BP=POS, Amin, Amax) ]
setkey(rsid_map.dt, rsid, Amin, Amax)

results_chrpos.dt <- rsid_map.dt[ results.dt ]
results_chrpos.dt[ grepl("^[1-9]", rsid), `:=`(
        CHR=as.integer(sub("_.+", "", rsid)),
        BP=as.integer(sub("^[1-9][0-9]?_([1-9][0-9]+)_[ATCG_]+$", "\\1", rsid))) ]

ukb_map.dt <- fread(cmd=paste("zcat", ukb_file))
setkey(ukb_map.dt, rsid, Amin, Amax)
ukb_map.dt <- ukb_map.dt[ !duplicated(ukb_map.dt) ]

results_chrpos_missing.dt <- results_chrpos.dt[ is.na(BP) ]
results_chrpos.dt <- results_chrpos.dt[ !is.na(BP) ]
results_chrpos_found.dt <- ukb_map.dt[ results_chrpos_missing.dt, nomatch=0 ]
results_chrpos.dt <- rbindlist(results_chrpos.dt, results_chrpos_found.dt)
results_chrpos.dt <- results_chrpos.dt[ order(CHR, BP) ]
setnames(results_chrpos.dt, "MarkerName", "#MarkerName")
results_chrpos.dt[, `:=`(Amin=NULL, Amax=NULL) ]
results_chrpos.dt[, MAF:=ifelse(Freq1 <= 0.5, Freq1, 1-Freq1) ]
results_chrpos.dt[, MAC:=round(MAF*2*Weight, 1) ]
results_chrpos.dt <- results_chrpos.dt[, .(
           `#MarkerName`, CHR, BP, Allele1, Allele2, Freq1, MAF, MAC, Weight, Zscore, P) ]

sink()
fwrite(results_chrpos.dt, "", quote=F, sep="\t", na="NA")
