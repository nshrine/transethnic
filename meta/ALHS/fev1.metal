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

PROCESS alhs_cases_fev1_nosmk_chr1_22_filtered.txt.gz
PROCESS alhs_cases_fev1_smk_chr1_22_filtered.txt.gz
PROCESS alhs_controls_fev1_nosmk_chr1_22_filtered.txt.gz
PROCESS alhs_controls_fev1_smk_chr1_22_filtered.txt.gz

OUTFILE ALHS_FEV1_ .tbl
ANALYZE
QUIT
