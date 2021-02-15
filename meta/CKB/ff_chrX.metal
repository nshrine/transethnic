SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       SNP     CHR     BP      P       EA      AA      BETA    SE      EA_FREQ INFO    N       MAC

MARKER unique_id
ALLELE EA AA
FREQ EA_FREQ
WEIGHT N
EFFECT BETA
PVALUE P

PROCESS ff_CKB_smk_CHRX_filtered.txt.gz
PROCESS ff_CKB_nonsmk_CHRX_filtered.txt.gz

OUTFILE CKB_FF_CHRX_ .tbl
ANALYZE
QUIT