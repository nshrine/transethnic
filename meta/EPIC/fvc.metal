SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

#unique_id       Markername      RSnum   Chrom   Pos     Bas_all Cod_all Freq    Beta    Se      Ntotal  Imp_info        MAC     P

MARKER unique_id
ALLELE Cod_all Bas_all
FREQ Freq
WEIGHT Ntotal
EFFECT Beta
PVALUE P

PROCESS EPIC_fvc_smk_CHRALL_filtered.txt.gz
PROCESS EPIC_fvc_nonsmk_CHRALL_filtered.txt.gz

OUTFILE EPIC_FVC_ .tbl
ANALYZE
QUIT
