SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       CHROM   POS     REF     ALT     N_INFORMATIVE   AF      U       V       STAT    DIRECTION       EFFECT  SE      PVALUE  ALT_Frq MAF     AvgCall Rsq     Genotyped       MAC     P

MARKER unique_id
ALLELE ALT REF
FREQ ALT_Frq
WEIGHT N_INFORMATIVE
EFFECT EFFECT
PVALUE P

PROCESS RS2_fev_ever_CHR1to22_filtered.txt.gz
PROCESS RS2_fev_never_CHR1to22_filtered.txt.gz

OUTFILE RS2_FEV1_ .tbl
ANALYZE
QUIT
