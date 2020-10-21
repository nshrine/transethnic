sink(stderr())

library(data.table)

args <- commandArgs(T)
infile <- args[1]
mapfile <- args[2]

# SNP     A1      A2      N       Z       FRQ
sumstats.dt <- fread(infile)
sumstats.dt[, `:=`(CHR=as.integer(sub("_.+", "", SNP)),
                   POS=as.integer(sub("^[1-9][0-9]?_([1-9][0-9]+)_[ATCG_]+$", "\\1", SNP)),
                   Amin=pmin(A1, A2), Amax=pmax(A1, A2)) ]
sumstats.dt <- sumstats.dt[ order(CHR, POS) ]
setkey(sumstats.dt, CHR, POS, Amin, Amax)

posfile <- sub(".sumstats.gz", ".pos.txt", infile)
fwrite(sumstats.dt[, .(CHR, POS) ], posfile, sep="\t", col.names=F)
rsid.dt <- fread(cmd=paste("tabix -h -R", posfile, mapfile))
setkey(rsid.dt, `#CHROM`, POS, Amin, Amax)
rsid.dt <- rsid.dt[ !duplicated(rsid.dt) ]

out.dt <- rsid.dt[ sumstats.dt, nomatch=0 ]
out.dt <- out.dt[, .(SNP=ID, A1, A2, N, Z, FRQ) ]

sink()
fwrite(out.dt, "", sep="\t")
