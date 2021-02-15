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

PROCESS NFBC86_FEV1pFVC_smk_chr1_22_filtered.txt.gz
PROCESS NFBC86_FEV1pFVC_nonsmk_chr1_22_filtered.txt.gz

OUTFILE NFBC86_FF_ .tbl
ANALYZE
QUIT
