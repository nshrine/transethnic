sink(stderr())
    
args <- commandArgs(T)
argc <- length(args)

if (argc < 1) {
    cat("Usage: sentinels.R HITS [ WIDTH (default", WIDTH, ")]\n")
    q()
}

hits <- args[1]
WIDTH <- ifelse(argc > 1, as.integer(args[2]), 500000)

suppressMessages(library(data.table))

#SNP    CHR BP  ALLELE1 ALLELE0 A1FREQ  INFO    BETA    SE  CHISQ_BOLT_LMM  P_BOLT_LMM  CHISQ_GC    P_GC

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
setnames(results.dt, "SNP", "rsid")
setnames(results.dt, "CHR", "chromosome")
setnames(results.dt, "BP", "position")
setnames(results.dt, "P_GC", "P")

sentinels.dt <- selectSentinels(results.dt)
setnames(sentinels.dt, c("chromosome", "position"), c("chrom", "pos"))
setkeyv(sentinels.dt, c("chrom", "pos"))
#sentinels.dt[ ! grepl("^chr|^\\d|^X", rsid), rsid:=sub(":.*", "", rsid) ]
#sentinels.dt[, rsid:=sub(":", "_", rsid) ]

sink()
write.table(sentinels.dt, "", row.names=F, quote=F, sep="\t")
