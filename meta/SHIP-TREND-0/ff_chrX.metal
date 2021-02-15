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

PROCESS SHIP-TREND-0_INVFF_smk_CHRX_males_filtered.gz
PROCESS SHIP-TREND-0_INVFF_smk_CHRX_females_filtered.gz
PROCESS SHIP-TREND-0_INVFF_nonsmk_CHRX_males_filtered.gz
PROCESS SHIP-TREND-0_INVFF_nonsmk_CHRX_females_filtered.gz

OUTFILE SHIP-TREND-0_FF_CHRX_ .tbl
ANALYZE
QUIT
