SHELL = /bin/bash

UKB_IMPUTED = /data/ukb/imputed_v3
UKB_EXOME = /data/ukb/exomes/23155
UKB_SAMPLE = /data/gen1/UKBiobank/application_648/UKBiobank_500K/ukb648_imp_chr1_v3_s487371.sample
SIGNALS_RAW = /scratch/gen1/jc824/transethnic/signal_selection/novel_signals/novel_signals.txt

CHROMS := $(shell seq 1 22)
BGENS := $(foreach c,$(CHROMS),$(subst CHR,$c,$(TMPDIR)/signals_ukb_chrCHR.bgen))
EXOME_BEDS := $(foreach c,$(CHROMS),$(subst CHR,$c,$(TMPDIR)/exome_ukb_chrCHR.bed))

.ONESHELL:

.DELETE_ON_ERROR:

.INTERMEDIATE: $(BGENS)

$(EXOME_BEDS): $(TMPDIR)/exome_ukb_chr%.bed:
	module load plink
	plink \
		--bed $(UKB_EXOME)/ukb23155_c$*_b0_v1.bed \
		--bim $(UKB_EXOME)/UKBexomeOQFE_chr$*.bim \
		--fam $(UKB_EXOME_SAMPLE) \



signals.bed: signals.bgen
	module load plink2
	plink2 --bgen $< ref-first --sample $(UKB_SAMPLE) --make-bed --out $(basename $@)

signals.bgen: $(BGENS)
	module load gcc
	~nrgs1/bin/cat-bgen -g $^ -og $@ -clobber


INCL_RANGE = $(shell awk '$$2 == $* { print ($$2 < 10 ? "0"$$2 : $$2)":"$$3"-"$$3 }' signals.txt)

$(BGENS): $(TMPDIR)/signals_ukb_chr%.bgen: 
	module load gcc
	~nrgs1/bin/bgenix -g $(UKB_IMPUTED)/ukb_imp_chr$*_v3.bgen -incl-range $(INCL_RANGE) > $@

signals.txt: $(SIGNALS_RAW)
	awk 'BEGIN { OFS = "\t" } NR > 1 { print $$6, $$7, $$8 }' $< > $@

UKBexomeOQFE.pos.gz:
	cut -f 1,4 $(UKB_EXOME)/UKBexomeOQFE_chr*.bim | gzip > $@
