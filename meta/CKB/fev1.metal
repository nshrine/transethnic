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

PROCESS fev_CKB_smk_CHR{1_22}_filtered.txt.gz
PROCESS fev_CKB_nonsmk_CHR{1_22}_filtered.txt.gz

OUTFILE CKB_FEV1_ .tbl
ANALYZE
QUIT
