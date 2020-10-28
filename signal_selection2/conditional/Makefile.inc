SHELL = /bin/bash

BASE = /data/gen1/LF_HRC_transethnic
PHENO = FEV1
CHR = 4
LOCUS = locus1
ROUND = 1
STEM = $(PHENO)_chr$(CHR)_$(LOCUS)_round$(ROUND)
COND = $(STEM).cond
META := $(STEM)_1.tbl
LOCI = ../$(PHENO)_chr$(CHR)_loci.txt
SENTINELS = ../$(PHENO)_chr$(CHR)_sentinels.txt
DESCRIPTIVES := ../../meta/descriptives_cols_$(PHENO).tsv
