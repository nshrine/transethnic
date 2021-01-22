SHELL = /bin/bash

UKB_IMP = /data/ukb/imputed_v3
UKB_SAMPLE_auto = /data/gen1/UKBiobank/application_648/UKBiobank_500K/ukb648_imp_chr1_v3_s487371.sample
UKB_SAMPLE_chrX = /data/gen1/UKBiobank/application_648/UKBiobank_500K/ukb648_imp_chrX_v3.sample

PREV279 = LF279.txt
LF279 := $(shell awk 'NR > 1 && $$2 < 23 { print $$1 }' $(PREV279))
LF279_BGEN := $(addprefix $(TMPDIR)/,$(addsuffix .bgen,$(LF279)))
CHR_279 = $(shell awk '$$1 == "$*" { print $$2 }' $(PREV279))
POS_279 = $(shell awk '$$1 == "$*" { print $$3 }' $(PREV279))
CHR0_279 = $(shell echo $(CHR_279) | awk '$$1 < 10 { $$1 = "0"$$1 } $$1 == 23 { $$1 = "X" } { print }')
LF279X :=  $(shell awk 'NR > 1 && $$2 == 23 { print $$1 }' $(PREV279))
LFF279X_BGEN := $(addprefix $(TMPDIR)/,$(addsuffix .bgen,$(LF279X)))

NEW_PREV = new_previous.txt
NPREV = $(shell awk 'NR > 1 && $$1 < 23 { print $$1"_"$$2 }' $(NEW_PREV))
NPREV_BGEN := $(addprefix $(TMPDIR)/,$(addsuffix .bgen,$(NPREV)))
CHR_NPREV = $(shell awk '$$1"_"$$2 == "$*" { print $$1 }' $(NEW_PREV))
POS_NPREV = $(shell awk '$$1"_"$$2 == "$*" { print $$2 }' $(NEW_PREV))
CHR0_NPREV = $(shell echo $(CHR_NPREV) | awk '$$1 < 10 { $$1 = "0"$$1 } $$1 == 23 { $$1 = "X" } { print }')
NPREVX :=  $(shell awk 'NR > 1 && $$1 == 23 { print $$1"_"$$2 }' $(NEW_PREV))
NPREVX_BGEN := $(addprefix $(TMPDIR)/,$(addsuffix .bgen,$(NPREVX)))

NPREV_CHECK := $(addsuffix _LD.ld,$(filter-out 6_108270570,$(NPREV)))
RSID_CHECK = $(shell awk '$$1 == $(CHR_NPREV) && $$4 == $(POS_NPREV) { print $$2 }' auto.bim)
NPREVX_CHECK := $(addsuffix _LD.ld,$(NPREVX))
RSIDX_CHECK = $(shell awk '$$4 == $(POS_NPREV) { print $$2 }' chrX.bim)

.ONESHELL:

.DELETE_ON_ERROR:

.INTERMEDIATE: $(LF279_BGEN) $(NPREV_BGEN)

.PHONY: all

all: $(NPREV_CHECK) $(NPREVX_CHECK)


$(NPREVX_CHECK): %_LD.ld: chrX.bed
	module load plink
	plink --bfile $(basename $<) --chr $(CHR_NPREV) --r2 yes-really --ld-window-kb 1000 --ld-window 1000000 --ld-window-r2 0.5 --ld-snp $(RSIDX_CHECK) --out $(basename $@)

$(NPREV_CHECK): %_LD.ld: auto.bed
	module load plink
	plink --bfile $(basename $<) --chr $(CHR_NPREV) --r2 yes-really --ld-window-kb 1000 --ld-window 1000000 --ld-window-r2 0.5 --ld-snp $(RSID_CHECK) --out $(basename $@)

auto.bed chrX.bed: %.bed: $(TMPDIR)/%.pgen
	module load plink2
	plink2 --pfile $(basename $<) --make-bed --out $(basename $@)

$(TMPDIR)/auto.pgen $(TMPDIR)/chrX.pgen: $(TMPDIR)/%.pgen: $(TMPDIR)/%.bgen
	module load plink2
	plink2 --bgen $< ref-first --sample $(UKB_SAMPLE_$*) --make-pgen --sort-vars --out $(basename $@)

$(TMPDIR)/auto.bgen: $(LF279_BGEN) $(NPREV_BGEN)
	module load gcc
	~nrgs1/bin/cat-bgen -g $^ -og $@ -clobber

$(TMPDIR)/chrX.bgen: $(LF279X_BGEN) $(NPREVX_BGEN)
	module load gcc
	~nrgs1/bin/cat-bgen -g $^ -og $@ -clobber

$(NPREV_BGEN) $(NPREVX_BGEN): $(TMPDIR)/%.bgen:
	module load gcc
	~nrgs1/bin/bgenix -g $(UKB_IMP)/ukb_imp_chr$(CHR_NPREV)_v3.bgen -incl-range $(CHR0_NPREV):$(POS_NPREV)-$(POS_NPREV) > $@

$(LF279_BGEN) $(LF279X_BGEN): $(TMPDIR)/%.bgen:
	module load gcc
	~nrgs1/bin/bgenix -g $(UKB_IMP)/ukb_imp_chr$(CHR_279)_v3.bgen -incl-range $(CHR0_279):$(POS_279)-$(POS_279) > $@
