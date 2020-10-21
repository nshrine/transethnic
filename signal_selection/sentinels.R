sink(stderr())
    
args <- commandArgs(T)
argc <- length(args)

if (argc < 1) {
    cat("Usage: sentinels.R HITS [ WIDTH (default", WIDTH, ")]\n")
    q()
}

hits <- args[1]
WIDTH <- ifelse(argc > 1, as.integer(args[2]), 1000000)

suppressMessages(library(data.table))

#rsid   CHR     BP      Allele1 Allele2 Freq1   MAF     MAC     Weight  Zscore  P

selectSentinels <- function(data.dt) {
    regions.list <- list()
    while(nrow(data.dt) > 0) {
        top.dt <- data.dt[ which.min(P) ]
        regions.list[[top.dt$rsid]] <- top.dt
        data.dt <- data.dt[ chromosome != top.dt$chromosome
            | position <= top.dt$position - WIDTH
            | position >= top.dt$position + WIDTH ]
    }
    rbindlist(regions.list)
}

results.dt <- fread(cmd=paste("zcat", hits))
setnames(results.dt, "#rsid", "rsid")
setnames(results.dt, "CHR", "chromosome")
setnames(results.dt, "BP", "position")

sentinels.dt <- selectSentinels(results.dt)
setnames(sentinels.dt, c("chromosome", "position"), c("chrom", "pos"))
setkeyv(sentinels.dt, c("chrom", "pos"))
#sentinels.dt[ ! grepl("^chr|^\\d|^X", rsid), rsid:=sub(":.*", "", rsid) ]
#sentinels.dt[, rsid:=sub(":", "_", rsid) ]

sink()
write.table(sentinels.dt, "", row.names=F, quote=F, sep="\t")
