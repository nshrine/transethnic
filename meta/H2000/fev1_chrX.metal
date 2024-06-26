SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       #CHROM  POS     ID      REF     ALT     A1      TEST    OBS_CT  BETA    SE      T_STAT  P       ALT_FREQS       NON_A1  FREQ1   MAC

MARKER unique_id
ALLELE A1 NON_A1
FREQ FREQ1
WEIGHT OBS_CT
EFFECT BETA
PVALUE P

PROCESS H2000_FEV1_smk_CHRX_males_filtered.txt.gz
PROCESS H2000_FEV1_smk_CHRX_females_filtered.txt.gz
PROCESS H2000_FEV1_nonsmk_CHRX_males_filtered.txt.gz
PROCESS H2000_FEV1_nonsmk_CHRX_females_filtered.txt.gz

OUTFILE H2000_FEV1_CHRX_ .tbl
ANALYZE
QUIT
