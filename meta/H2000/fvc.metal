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

PROCESS H2000_FVC_smk_CHR1_22_filtered.txt.gz
PROCESS H2000_FVC_nonsmk_CHR1_22_filtered.txt.gz

OUTFILE H2000_FVC_ .tbl
ANALYZE
QUIT
