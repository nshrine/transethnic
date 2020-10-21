include ../Makefile.inc
include Makefile.inc

COHORTS := $(shell cut -f 1 studies.txt)
COJOS := $(foreach c,$(COHORTS),$(subst COHORT,$c,COHORT/COHORT_$(STEM).cma.cojo))
COJOS_FORMATTED := $(subst cma.cojo,cma.txt,$(COJOS))
#MAS := $(foreach c,$(COHORTS),$(subst COHORT,$c,COHORT/COHORT_$(PHENO).ma))
METAL = $(STEM).metal
METAL_JOINT = $(STEM)_joint.metal
META := $(STEM)_1.tbl
META_JOINT := $(STEM)_joint_1.tbl
JOINTS := $(subst cma,jma,$(COJOS))
JOINTS_FORMATTED := $(subst cma,jma,$(COJOS_FORMATTED))

.ONESHELL:

.DELETE_ON_ERROR:

.PHONY: all joint $(COJOS) $(JOINTS)


all: $(META)

joint: $(META_JOINT)

# Chr     SNP     bp      refA    freq    b       se      p       n       freq_geno       bC      bC_se   pC

%_1.tbl: %.metal
	metal $< | tee $(@:_1.tbl=.log)

$(METAL): $(COJOS_FORMATTED)

$(METAL_JOINT): $(JOINTS_FORMATTED)

$(METAL) $(METAL_JOINT):
	cat > $@ <<-EOT
		SEPARATOR  TAB
		AVERAGEFREQ ON
		SCHEME SAMPLESIZE
	
		MARKER SNP
		ALLELE refA nonrefA
		FREQ freq
		WEIGHT n
		EFFECT $(if $(findstring joint,$@),bJ,bC)
		PVALUE $(if $(findstring joint,$@),pJ,pC)
		
	EOT
	
	for i in $(COHORTS); do
	awk '$$1 == "Intercept:" { print "GENOMICCONTROL", ($$2 > 1.0 ? $$2 : "OFF") }' $(dir $(DESCRIPTIVES))$${i}/$${i}_$(PHENO)_h2.log
		echo "PROCESS $${i}/$${i}_$(STEM).$(if $(findstring joint,$@),jma,cma).txt"
		echo
	done >> $@
	
	cat >> $@ <<-EOT
		OUTFILE $(@:.metal=_) .tbl
		ANALYZE
		QUIT
	EOT
	
$(COJOS_FORMATTED): %_$(STEM).cma.txt: %_$(STEM).cma.cojo

vpath %_$(STEM).cma.cojo $(COHORTS)

$(JOINTS_FORMATTED): %_$(STEM).jma.txt: %_$(STEM).jma.cojo

vpath %_$(STEM).jma.cojo $(COHORTS)

$(COJOS_FORMATTED) $(JOINTS_FORMATTED):
	module load R
	Rscript - <<-RSCRIPT
		library(tidyverse)
		read_tsv("$<") %>%
			mutate(tmpID=sub("^[1-9][0-9]?_", "", SNP)) %>%
			separate(tmpID, c("rsid", "Amin", "Amax")) %>%
			mutate(nonrefA=ifelse(refA == Amin, Amax, Amin)) %>%
			select(SNP, refA, nonrefA, freq, n, $(if $(findstring jma,$@),bJ,bC), $(if $(findstring jma,$@),pJ,pC)) %>%
			write_tsv("$@")
	RSCRIPT
			
#$(COJOS): %_$(STEM).cma.cojo: %_$(PHENO).ma $(COND)
$(COJOS): %_$(STEM).cma.cojo:
	$(MAKE) -f Makefile.cohort PHENO=$(PHENO) CHR=$(CHR) LOCUS=$(LOCUS) COHORT=$(notdir $*) ROUND=$(ROUND)
	
#$(JOINTS): %_$(STEM).jma.cojo: %_$(PHENO).ma $(COND)
$(JOINTS): %_$(STEM).jma.cojo: 
	$(MAKE) -f Makefile.cohort joint PHENO=$(PHENO) CHR=$(CHR) LOCUS=$(LOCUS) COHORT=$(notdir $*) ROUND=$(ROUND)
	
vpath %_$(PHENO).ma $(COHORTS)

#$(MAS): %_$(PHENO).ma: FORCE
#	$(MAKE) -f Makefile.cohort $@ PHENO=$(PHENO) COHORT=$(notdir $*)

