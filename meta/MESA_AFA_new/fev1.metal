SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       SNPID   Chr     Position        coded_all       noncoded_all    strand_genome   Beta    SE      pval    AF_coded_all    HWE_pval        n_total Genotyped       imputation_Rsq  MAC

MARKER unique_id
ALLELE coded_all noncoded_all
FREQ AF_coded_all
WEIGHT n_total
EFFECT Beta
PVALUE pval

PROCESS MESA_AFA_FEV1_smk_CHR1_22_filtered.txt.gz
PROCESS MESA_AFA_FEV1_nonsmk_CHR1_22_filtered.txt.gz

OUTFILE MESA_AFA_FEV1_ .tbl
ANALYZE
QUIT
