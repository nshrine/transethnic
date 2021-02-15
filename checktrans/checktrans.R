library(data.table)
library(ggplot2)
library(broom)

trans_dir <- "/data/gen1/LF_HRC_transethnic/original_files_as_downloaded"
untrans_dir <- "/data/gen1/LF_HRC_transethnic/untransformed_original"

args <- commandArgs(T)
argc <- length(args)

cohort <- ifelse(argc > 0, args[1], "ALHS")
i <- ifelse(argc > 1, as.integer(args[2]), 1)

descriptives.dt <- fread("../meta/descriptives_cols_FEV1.tsv")
files.dt <- fread("files.txt")

get_plot_data <- function(cohort, transfile, untransfile) {
    subset_res <- function(res) {
        res.dt <- fread(res)
        cols <- as.character(descriptives.dt[ study == cohort ])
        cols[ is.na(cols) ] <- "NA"
        setnames(res.dt, cols, names(descriptives.dt), skip_absent=TRUE)
        res.dt[ !is.na(beta), .(Chromosome, Position,
                                Amin=pmin(effectallele, otherallele),
                                Amax=pmax(effectallele, otherallele),
                                beta, se) ]
    }

    trans <- paste(trans_dir, cohort, transfile, sep="/")
    trans.dt <- subset_res(trans)
    setkey(trans.dt, Chromosome, Position, Amin, Amax)
    untrans <-  paste(untrans_dir, cohort, untransfile, sep="/")
    untrans.dt <- subset_res(untrans)
    setkey(untrans.dt, Chromosome, Position, Amin, Amax)

    comp.dt <- trans.dt[ untrans.dt, nomatch=0 ]
    long.dt <- melt.data.table(comp.dt, measure=patterns(c("^i", "^[bs]")), value.name=c("untransformed", "transformed"))
    long.dt[, variable:=ifelse(variable == 1, "beta", "se") ]
}

fil.dt <- files.dt[ study == cohort ]

transfile <-  fil.dt$transformed[i]
untransfile <- fil.dt$untransformed[i]
plot.dt <- get_plot_data(cohort, transfile, untransfile)

fitted_slope <- function(x) {
    fit.lm <- lm(untransformed ~ transformed - 1, plot.dt[ variable == x ])
    tidy(fit.lm)$estimate
}

slopes.list <- lapply(list(beta="beta", se="se"), fitted_slope)

plot_title <- paste0("Transformed: ", transfile,
                    "\nUntransformed: ", untransfile,
                    "\nbeta slope: ", round(slopes.list$beta, 2), "; se slope: ", round(slopes.list$se, 2))
                    
png(file=paste0(cohort, "/", cohort, "_", i, ".png"), width=1000, height=400)
ggplot(plot.dt, aes(x=transformed, y=untransformed)) +
    geom_point() + geom_smooth(method="lm", formula=y ~ x - 1) +
    facet_wrap(~variable, scales="free") + ggtitle(plot_title) 
null <- dev.off()
