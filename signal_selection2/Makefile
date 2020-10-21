SHELL = /bin/bash

include Makefile.inc

RESULTS = $(PHENO)_1.tbl
RESULTS_CHR = $(PHENO)_1_chr$(CHR).tbl
STEM = $(PHENO)_chr$(CHR)
FILTERED = $(STEM)_filtered.txt.gz
SENTINELS = $(STEM)_sentinels.txt
LOCI = $(STEM)_loci.txt

.ONESHELL:

.DELETE_ON_ERROR:

.PHONY: all

all: $(LOCI)

$(LOCI): merge_loci.R $(SENTINELS)
	module load R
	Rscript $^ $(WIDTH) > $@

$(SENTINELS): sentinels.R $(FILTERED)
	module load R
	Rscript $^ $(WIDTH) > $@

$(FILTERED): $(RESULTS_CHR)
	awk 'NR == 1 || $$8 >= $(MAC) && $$11 < $P' $< | gzip > $@

$(RESULTS_CHR): formatmeta.awk $(RESULTS)
	./$^
