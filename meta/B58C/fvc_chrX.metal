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

PROCESS B58C-HRC_FVC_smk_CHRX_males_filtered.txt.gz
PROCESS B58C-HRC_FVC_smk_CHRX_females_filtered.txt.gz
PROCESS B58C-HRC_FVC_nonsmk_CHRX_males_filtered.txt.gz
PROCESS B58C-HRC_FVC_nonsmk_CHRX_females_filtered.txt.gz

OUTFILE B58C_FVC_CHRX_ .tbl
ANALYZE
QUIT
