SHELL = /bin/bash

include Makefile.inc

RESULTS = $(PHENO)_big_METAL_results1.gz
RESULTS_CHRPOS = $(PHENO)_big_METAL_results1_chrpos.txt.gz
BASE = /data/gen1/LF_HRC_transethnic/metal/big_METAL
STEM = $(PHENO)_chr$(CHR)
FILTERED = $(STEM)_filtered.txt.gz
SENTINELS = $(STEM)_sentinels.txt
LOCI = $(STEM)_loci.txt

.ONESHELL:

.DELETE_ON_ERROR:

.PHONY: addchrpos all

all: $(LOCI)

addchrpos: $(RESULTS_CHRPOS)

$(LOCI): merge_loci.R $(SENTINELS)
	module load R
	Rscript $^ $(WIDTH) > $@

$(SENTINELS): sentinels.R $(FILTERED)
	module load R
	Rscript $^ $(WIDTH) > $@

$(FILTERED): $(RESULTS_CHRPOS)
	tabix -h $< $(CHR) | awk 'NR == 1 || $$2 == $(CHR) && $$8 >= $(MAC) && $$11 < $P' | gzip > $@

$(RESULTS_CHRPOS): addchrpos.R $(RESULTS)
	module load R
	module load tabix
	Rscript $^ | bgzip > $@
	-tabix -s 2 -b 3 -e 3 $@

$(RESULTS): $(BASE)/$(RESULTS:gz=tbl)
	cut -f 1-4,8-10 $< | awk 'BEGIN { OFS = "\t" } NR > 1 { $$2 = toupper($$2); $$3 = toupper($$3) } { print }' | gzip >| $@
