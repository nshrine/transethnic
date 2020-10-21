SHELL = /bin/bash

INFO_MIN = 0.5

MUNGE = ./ldsc/munge_sumstats.py
LDSC = ./ldsc/ldsc.py
DESC = descriptives_cols_$(PHENO).tsv
PHENO = FEV1
COHORTS := $(shell awk 'NR > 1 { print $$1 }' $(DESC))
SUMSTATS := $(foreach c,$(COHORTS),$(subst COHORT,$c,COHORT/COHORT_$(PHENO).sumstats.gz))
RESULTS_LDSC := $(subst .sumstats.gz,_ldsc.gz,$(SUMSTATS))
#study=$1
#Software=$2
#Build=$3
#SNPID=$4
#Chromosome=$5
#Position=$6
#effectallele=$7
#otherallele=$8
#EAF=$9
#beta=$10
#se=$11
#P=$12
#N=$13
#INFO=$14
#filtered=$15
RESULTS = $(shell awk '$$1 == "$(*F)" { print $$15 }' $(DESC))
#SNP = $(shell awk '$$1 == "$(*F)" { print $$4 }' $(DESC))
META_STUDIES := $(shell cat meta_studies_$(PHENO).txt)
# CHR     BP      ldsc_id   Allele1 Allele2 Freq1   FreqSE  Weight  Zscore  P-value Direction
#ID = $(if $(findstring $(*F),$(META_STUDIES)),MarkerName,unique_id)
ID = $(shell awk '$$1 == "$(*F)" { print "MarkerName"; found = 1; exit } END { if (!found) print "unique_id" }' meta_studies_$(PHENO).txt)
A1 = $(if $(findstring $(*F),$(META_STUDIES)),Allele1,$(shell awk '$$1 == "$(*F)" { print $$7 }' $(DESC)))
A2 = $(if $(findstring $(*F),$(META_STUDIES)),Allele2,$(shell awk '$$1 == "$(*F)" { print $$8 }' $(DESC)))
BETA = $(if $(findstring $(*F),$(META_STUDIES)),Zscore,$(shell awk '$$1 == "$(*F)" { print $$10 }' $(DESC)))
SE = $(if $(findstring $(*F),$(META_STUDIES)),1,$(shell awk '$$1 == "$(*F)" { print $$11 }' $(DESC)))
sp :=
sp +=
N_ARG = $(if $(findstring $(*F),$(META_STUDIES)),--N-col$(sp)Weight,$(shell awk '$$1 == "$(*F)" { print ($$13 ~ /^[1-9][0-9]+$$/ ? "--N "$$13 : "--N-col "$$13) }' $(DESC)))
WEIGHT_ARG = $(if $(findstring $(*F),$(META_STUDIES)),WEIGHT$(sp)Weight,$(shell awk '$$1 == "$(*F)" { print ($$13 ~ /^[1-9][0-9]+$$/ ? "DEFAULTWEIGHT "$$13 : "WEIGHT "$$13) }' $(DESC)))
P = $(if $(findstring $(*F),$(META_STUDIES)),P-value,$(shell awk '$$1 == "$(*F)" { print ($$12 == "NA" ? "P" : $$12) }' $(DESC)))
INFO_ARG = $(if $(findstring $(*F),$(META_STUDIES)),,$(shell awk '$$1 == "$(*F)" { print "--info "$$14" --info-min $(INFO_MIN)" }' $(DESC)))
FRQ = $(if $(findstring $(*F),$(META_STUDIES)),Freq1,$(shell awk '$$1 == "$(*F)" { print $$9 }' $(DESC)))
LDSCORE := $(subst .sumstats.gz,_h2.log,$(SUMSTATS))
REF_BASE = /data/gen1/reference/ldsc
ANCESTRY = $(shell awk '$$1 == "$(*F)" { print tolower($$2) }' ancestry_studies.txt)
REF = $(REF_BASE)/$(ANCESTRY)_w_ld_chr/
SETUP_PYTHON = module load python/gcc/2.7.13; export PYTHONPATH=~/lib/python2.7/site-packages
METAL := $(PHENO).metal
COHORT_METAL := $(foreach c,$(COHORTS),$(subst COHORT,$c,$(TMPDIR)/COHORT_$(PHENO).metal))
GC = $(shell awk '$$1 == "Intercept:" { print ($$2 > 1.0 ? $$2 : "OFF") }' $*/$*_$(PHENO)_h2.log)

.ONESHELL:

.INTERMEDIATE: $(COHORT_METAL)

.PHONY: all

all: $(PHENO)_1.tbl

%_1.tbl: %.metal
	metal $< | tee $(@:_1.tbl=.log)

$(METAL): $(COHORT_METAL) $(LDSCORE)
	cat > $@ <<-EOT
		SEPARATOR  TAB
		AVERAGEFREQ ON
		SCHEME SAMPLESIZE
		
	EOT
	
	cat $(COHORT_METAL) >> $@
	
	cat >> $@ <<-EOT
		OUTFILE $(@:.metal=_) .tbl
		ANALYZE
		QUIT
	EOT
	
$(COHORT_METAL): $(TMPDIR)/%_$(PHENO).metal: 
	cat > $@ <<-EOT
		MARKER $(ID)
		ALLELE $(A1) $(A2)
		FREQ $(FRQ)
		$(WEIGHT_ARG)
		EFFECT $(BETA)
		PVALUE $(P)
		GENOMICCONTROL $(GC)
		PROCESS $(RESULTS)
		
	EOT

$(LDSCORE): %_$(PHENO)_h2.log: %_$(PHENO).sumstats.gz | $(LDSC)
	$(SETUP_PYTHON)
	$(LDSC) --h2 $< \
		--ref-ld-chr $(REF) \
		--w-ld-chr $(REF) \
		--out $(@:.log=)

vpath %_$(PHENO).sumstats.gz $(COHORTS)

$(SUMSTATS): %_$(PHENO).sumstats.gz: %_$(PHENO)_ldsc.gz | $(MUNGE)
	$(SETUP_PYTHON)

	$(MUNGE) --sumstats $< \
		--snp ldsc_id \
		--a1 $(A1) --a2 $(A2) \
		--signed-sumstats $(BETA),0 \
		$(N_ARG) \
		--p $P \
		$(INFO_ARG) \
		--frq $(FRQ) \
		--out $(@:.sumstats.gz=)
# --signed-sumstats Zscore,0 \

vpath %_$(PHENO)_ldsc.gz $(COHORTS)

.SECONDEXPANSION:
$(RESULTS_LDSC): %_$(PHENO)_ldsc.gz: $$(RESULTS)
	module load R
	Rscript --default-packages=tidyverse - <<-RSCRIPT
		results <- read_tsv("$(RESULTS)") %>%
			separate($(ID), c("CHR", "BP", "Amin", "Amax"), sep="_", convert=TRUE) %>%
			mutate(CHR=ifelse(CHR == "X", 23, CHR) %>% as.integer) %>%
			mutate_at(vars(matches("R2")), ~ifelse(. == "typed only", 1, .) %>% as.numeric) %>%
			add_count(CHR, BP, name="chrbp_count") %>%
			filter(chrbp_count == 1) %>%
			select(-Amin, -Amax, -chrbp_count)
		
		ref <- tibble(chr=1:22) %>%
			group_by(chr) %>%
			do(paste0("$(REF)", .$$chr, ".l2.ldscore.gz") %>% read_tsv) %>%
			ungroup %>%
			select(CHR, BP, ldsc_id=SNP)
		
		ldsc <- inner_join(ref, results, c("CHR", "BP"))
#		if (!"Zscore" %in% names(ldsc))
#			ldsc <- ldsc %>% mutate(Zscore=$(BETA)/$(SE))
		
		write_tsv(ldsc, "$@")
	RSCRIPT

$(MUNGE) $(LDSC):
	git clone https://github.com/bulik/ldsc.git
