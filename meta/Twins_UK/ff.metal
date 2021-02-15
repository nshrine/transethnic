SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       chr     rs      ps      n_miss  allele1 allele0 af      beta    se      MAC     P

MARKER unique_id
ALLELE allele1 allele0
FREQ af
DEFAULTWEIGHT 4225
EFFECT beta
PVALUE p_wald

PROCESS Twins.UK_FEV1_FVC_adjusted_smk_CHR1_22_filtered.txt.gz

OUTFILE Twins_UK_FF_ .tbl
ANALYZE
QUIT
