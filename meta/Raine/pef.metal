SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

#unique_id       SNPID   RSID    CHR     POS     EFFECT_ALLELE   NON_EFFECT_ALLELE       N       EAF     HWE_P   CALL_RATE       BETA    SE      PVAL    IMPUTED INFO_TYPE       INFO    MAC

MARKER unique_id
ALLELE EFFECT_ALLELE NON_EFFECT_ALLELE
FREQ EAF
WEIGHT N
EFFECT BETA
PVALUE PVAL

PROCESS Raine_PEF_all_CHR1_22_filtered.txt.gz

OUTFILE Raine_PEF_ .tbl
ANALYZE
QUIT
