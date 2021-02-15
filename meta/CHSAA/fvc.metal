SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       SNPID   chr     position        coded_all       noncoded_all    beta    SE      pval    AF_coded_all    n_total imputed oevar_imp       effsample       MAC

MARKER unique_id
ALLELE coded_all noncoded_all
FREQ AF_coded_all
WEIGHT n_total
EFFECT beta
PVALUE pval

PROCESS CHSAA_FVC_smk_CHR1_22_filtered.txt.gz
PROCESS CHSAA_FVC_nonsmk_CHR1_22_filtered.txt.gz

OUTFILE CHSAA_FVC_ .tbl
ANALYZE
QUIT
