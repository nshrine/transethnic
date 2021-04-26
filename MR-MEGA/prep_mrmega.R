library(data.table)

untrans_dir <- "/data/gen1/LF_HRC_transethnic/untransformed_original"

args <- commandArgs(T)
argc <- length(args)

cohort <- ifelse(argc > 0, args[1], "ALHS")
i <- ifelse(argc > 1, as.integer(args[2]), 1)

descriptives_untrans.dt <- fread("../meta/descriptives_cols_untrans.tsv")
files.dt <- fread("files.txt")

subset_res <- function(res, desc.dt=descriptives_untrans.dt) {
    cols <- as.character(desc.dt[ study == cohort ])
    cols[ is.na(cols) ] <- paste("NA", which(is.na(cols)), sep="_")

    fread_cmd <- paste(ifelse(grepl("\\.gz$", res), "zgrep", "grep"), "-v '^#'", res,
                       ifelse(cols[2] == "SNPTEST", "| ../meta/snptestfreq.awk", ""))
    if (grepl("SAPALDIA", cohort))
        fread_cmd <- paste("zcat", res, "| awk 'BEGIN { OFS = \"\\t\" } NR == 1 { sub(\"^#\", \"\", $1); print $0, \"NONREF\"; next } { print $0, ($6 == $4 ? $5 : $4) }'")
    res.dt <- fread(cmd=fread_cmd)
    setnames(res.dt, cols, names(desc.dt), skip_absent=TRUE)
    res.dt[, `:=`(Chromosome=as.integer(ifelse(Chromosome == "X", "23", Chromosome)),
                            Position=as.integer(Position),
                            beta=as.numeric(beta), se=as.numeric(se)) ][ is.finite(beta) & is.finite(se) ]
}

fil.dt <- files.dt[ study == cohort ]

untransfile <- paste(untrans_dir, cohort, fil.dt$untransformed[i], sep="/")
subset.dt <- subset_res(untransfile)
out.dt <- subset.dt[, .(MARKERNAME=paste(Chromosome, Position, pmin(effectallele, otherallele), pmax(effectallele, otherallele), sep="_"),
                        EA=effectallele, NEA=otherallele, BETA=beta, SE=se, EAF, N, CHROMOSOME=Chromosome, POSITION=Position) ]

write.table(out.dt, "", row.names=F, quote=F, sep="\t")
