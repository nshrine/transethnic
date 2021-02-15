SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       SNP     REF     ALT     CHROM   POS     N_INFORMATIVE   AF      U       V       STAT    DIRECTION       EFFECT  SE      PVALUE  Rsq     MAC

MARKER unique_id
ALLELE ALT REF
FREQ AF
WEIGHT N_INFORMATIVE
EFFECT EFFECT
PVALUE PVALUE

PROCESS	ARIC_AA_PEF_smk_filtered.txt.gz
PROCESS ARIC_AA_PEF_nonsmk_filtered.txt.gz

OUTFILE ARIC_AA_PEF_ .tbl
ANALYZE
QUIT