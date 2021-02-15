SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       Markername      Chrom   Pos     Bas_all Cod_all Freq    Beta    Se      Ntotal  Imp_info        MAC     P

MARKER unique_id
ALLELE Cod_all Bas_all
FREQ Freq
WEIGHT Ntotal
EFFECT Beta
PVALUE P

PROCESS PIVUS_fev1_smk_CHR1-22_filtered.txt.gz
PROCESS PIVUS_fev1_nonsmk_CHR1-22_filtered.txt.gz

OUTFILE PIVUS_FEV1_ .tbl
ANALYZE
QUIT
