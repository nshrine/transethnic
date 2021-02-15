SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       CHR:POS:Allele  ID      CHROM   POS     REF     ALT     N_INFORMATIVE   AF      U       V       STAT    DIRECTION       EFFECT  SE      PVALUE  Rsq     MAC

MARKER unique_id
ALLELE ALT REF
FREQ AF
WEIGHT N_INFORMATIVE
EFFECT EFFECT
PVALUE PVALUE

PROCESS alhs_cases_ff_nosmk_chr1_22_filtered.txt.gz
PROCESS alhs_cases_ff_smk_chr1_22_filtered.txt.gz
PROCESS alhs_controls_ff_nosmk_chr1_22_filtered.txt.gz
PROCESS alhs_controls_ff_smk_chr1_22_filtered.txt.gz

OUTFILE ALHS_FF_ .tbl
ANALYZE
QUIT
