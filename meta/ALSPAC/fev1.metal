SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       alternate_ids   rsid    chromosome      position        alleleA alleleB index   average_maximum_posterior_call  info    cohort_1_AA     cohort_1_AB     cohort_1_BB     cohort_1_NULL   all_AA  all_AB  all_BB  all_NULL    all_total        all_maf missing_data_proportion cohort_1_hwe    frequentist_add_pvalue  frequentist_add_info    frequentist_add_beta_1  frequentist_add_se_1    comment freqB   MAC

MARKER unique_id
ALLELE alleleB alleleA
FREQ freqB
WEIGHT all_total
EFFECT frequentist_add_beta_1
PVALUE frequentist_add_pvalue

PROCESS ALSPAC_zfev1_all_chr1_22_filtered.txt.gz

OUTFILE ALSPAC_FEV1_ .tbl
ANALYZE
QUIT
