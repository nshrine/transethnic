SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       CHR     POS     NONEFFECT       EFFECT  N       EAF     BETA    SE_BETA IMP_RSQ GENO    VCFID   MAC     P

MARKER unique_id
ALLELE EFFECT NONEFFECT
FREQ EAF
WEIGHT N
EFFECT BETA
PVALUE P

PROCESS B58C-HRC_FEV1_smk_CHR1-22_filtered.txt.gz
PROCESS B58C-HRC_FEV1_nonsmk_CHR1-22_filtered.txt.gz

OUTFILE B58C_FEV1_ .tbl
ANALYZE
QUIT
