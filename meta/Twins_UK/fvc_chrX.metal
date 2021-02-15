SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       chr     rs      ps      n_miss  allele1 allele0 af      beta    se      MAC     P

MARKER unique_id
ALLELE allele1 allele0
FREQ af
EFFECT beta
PVALUE p_wald

DEFAULTWEIGHT 380
PROCESS Twins.UK_FVC_adjusted_smk_males_CHRX_filtered.txt.gz
DEFAULTWEIGHT 3845
PROCESS Twins.UK_FVC_adjusted_smk_females_CHRX_filtered.txt.gz

OUTFILE Twins_UK_FVC_CHRX_ .tbl
ANALYZE
QUIT
