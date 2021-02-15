SEPARATOR  TAB
AVERAGEFREQ ON
SCHEME SAMPLESIZE

# unique_id       Chr     SNPID   Phys_location   phen    N       iMAF    variMAF h2q     beta    se      chisq   pval    rsid    effect  noneffect       obs_eaf ratio   input_snp       iwgadiff        iwgafold        inrefgene       refge

MARKER unique_id
ALLELE effect noneffect
FREQ obs_eaf
WEIGHT N
EFFECT beta
PVALUE pval

PROCESS FHS_FVC_all_CHR122_filtered.txt.gz

OUTFILE FHS_FVC_ .tbl
ANALYZE
QUIT
