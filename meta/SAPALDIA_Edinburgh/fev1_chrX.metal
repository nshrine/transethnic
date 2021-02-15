SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       CHROM   POS     ID      REF     ALT1    A1      A1_FREQ MACH_R2 OBS_CT  BETA    SE      P       NONREF  MAC

MARKER unique_id
ALLELE A1 NONREF
FREQ A1_FREQ
WEIGHT OBS_CT
EFFECT BETA
PVALUE P

PROCESS SAPALDIA_Edinburgh_FEV1_smk_CHRX_males_filtered.txt.gz
PROCESS SAPALDIA_Edinburgh_FEV1_smk_CHRX_females_filtered.txt.gz
PROCESS SAPALDIA_Edinburgh_FEV1_nonsmk_CHRX_males_filtered.txt.gz
PROCESS SAPALDIA_Edinburgh_FEV1_nonsmk_CHRX_females_filtered.txt.gz

OUTFILE SAPALDIA_Edinburgh_FEV1_CHRX_ .tbl
ANALYZE
QUIT
