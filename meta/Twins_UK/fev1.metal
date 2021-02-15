SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       chr     rs      ps      n_miss  allele1 allele0 af      beta    se      MAC     P

MARKER unique_id
ALLELE allele1 allele0
FREQ af
DEFAULTWEIGHT 4225
EFFECT beta
PVALUE P

PROCESS Twins.UK_FEV1_adjusted_smk_CHR1_22_filtered.txt.gz

OUTFILE Twins_UK_FEV1_ .tbl
ANALYZE
QUIT
