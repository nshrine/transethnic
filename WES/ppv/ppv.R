library(data.table)

get_dose_m <- function(infile) {
    dose.dt <- fread(infile)

    # Change FID to <char> for use as row names to avoid confusion between integer row name and row number
    dose.dt[, FID:=paste0("ID_", FID) ]
    dose.dt <- dose.dt[ order(FID) ]
    dose.m <- as.matrix(dose.dt[, -(2:6), with=FALSE ], rownames=TRUE)

    # Set all rare homs (dose == 2) to missing
    apply(dose.m, 1, function(x) ifelse(x == 2, NA, x))
}

get_roc <- function(wes_geno, array_geno) {
    wes.m <- get_dose_m(wes_geno)
    array.m <- get_dose_m(array_geno)
    
    # Check samples and variants  same in both
    stopifnot(identical(colnames(wes.m), colnames(array.m)))
    stopifnot(identical(rownames(wes.m), rownames(array.m)))
    
    # If we make the dose of the 2 samples a binary digit i.e. value = 2*wes + array then we have combinations:
    # 00, value = 0 = hom-hom = TN
    # 01, value = 1 = hom-het = FP
    # 10, value = 2 = het-hom = FN
    # 11, value = 3 = het-het = TP
    comp.m <- 2*wes.m + array.m
    values.m <- apply(comp.m, 1, function(x) as.numeric(table(factor(x, levels=0:3))))
    roc.dt <- data.table(colnames(values.m), t(values.m))
    setnames(roc.dt, c("SNP", "TN", "FP", "FN", "TP"))
    roc.dt[, `:=`(SNP = sub("_[ATCG]+$", "", SNP),
                  sensitivity = TP / (TP + FN),
                  specificity = TN / (TN + FP),
                  PPV = TP / (TP + FP),
                  NPV = TN / (TN + FN)) ]
}
