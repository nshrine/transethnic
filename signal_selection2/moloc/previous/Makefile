SHELL = /bin/bash

SNP151 = /data/gen1/reference/dbsnp/snp151_map.txt.gz

SIGNALS = all_signal_summary.txt
# locus   start   end     sentinel        chr     pos     trait

BIG_METAL := /data/gen1/LF_HRC_transethnic/metal/big_METAL/$(PHENO)_big_METAL_chr_pos_a1_a2_results1.tbl
SMALL_METAL := $(PHENO)_small_metal.txt.gz
LOCUS := $(shell awk '$$4 == "$(SENTINEL)" && $$NF == "$(PHENO)" { print $$1 }' $(SIGNALS))
CHR := $(shell echo $(SENTINEL) | cut -f 1 -d '_')
POS := $(shell echo $(SENTINEL) | cut -f 2 -d '_')
START := $(shell awk '$$4 == "$(SENTINEL)" && $$NF == "$(PHENO)" { print $$2 }' $(SIGNALS))
END := $(shell awk '$$4 == "$(SENTINEL)" && $$NF == "$(PHENO)" { print $$3 }' $(SIGNALS))
AMIN := $(shell echo $(SENTINEL) | cut -f 3 -d '_')
AMAX := $(shell echo $(SENTINEL) | cut -f 4 -d '_')
EPACTS := $(PHENO)_$(SENTINEL).epacts.gz
MARKERS = markers.txt

#rsid    chr     pos     Amin    Amax
#rs1214600967    10      122228098       C       T
#REAL_SNP = $(or $(shell zcat $(TMPDIR)/$(SENTINEL)_rsid.txt.gz | awk '$$2 == $(CHR) && $$3 == $(POS) && $$4 == "$(AMIN)" && $$5 == "$(AMAX)" { print $$1 }'),$(SENTINEL))
REAL_SNP = $(or $(shell zcat $(TMPDIR)/$(SENTINEL)_rsid.txt.gz | awk '$$2 == $(CHR) && $$3 == $(POS) { print $$1 }'),$(SENTINEL))

PDF = $(PHENO)_$(SENTINEL).pdf
PNG = $(PHENO)_$(SENTINEL).png

.ONESHELL:

.DELETE_ON_ERROR:

.PHONY: all epacts pdf png

.INTERMEDIATE: $(RESULTS_PRIMARY) $(RESULTS_SECONDARY) $(LD_PLOT)

all: png

epacts: $(EPACTS)

png: $(PNG)

pdf: $(PDF)

test:
	@echo $(REAL_SNP)

$(PNG): $(PHENO)_%.png: $(PHENO)_%.pdf
	convert -density 400 $<[0] $@

#EPACTS=$1
#PREFIX=$2
#CHR=$3
#START=$4
#END=$5
#SNP=$6
#TITLE=$7

$(PDF): $(PHENO)_%.pdf: $(PHENO)_%.epacts.gz $(MARKERS)
	@echo $(CHR)
	@echo $(START)
	@echo $(END)
	@echo $(REAL_SNP)
	module load plink R
	./region_plot.sh $< $(basename $@) $(CHR) $(START) $(END) "$(REAL_SNP)" "$(PHENO) unconditional" $(lastword $^) 2> \
		>(grep -v "has more than 1 position") && mv $(basename $@)_$(REAL_SNP).pdf $@
	
#$(LD_PLOT): $(TMPDIR)/%.ld: ../ld/%.ld
#	awk '$$2 ~ /^rs/ || $$2 ~ /^Affx/ {
#		sub("_.*", "", $$2)
#	}
#
#	{
#		print
#	}' $< > $@

#markers.txt: $(SIGNALS) $(PREV)
#	awk -F '\t' -F '\t' 'BEGIN {
#		OFS = "\t"
#		print "snp", "string", "color"
#	}
#
#	NR == FNR && NR > 1 {
#		print $$6, toupper($$3), "black"
#	}
#
#	NR > FNR && FNR > 1 {
#		print $$6, $$4, ($$5 == "tier_3" ? "blue" : "red")
#	}' $^ > $@

$(EPACTS): $(PHENO)_%.epacts.gz: $(TMPDIR)/$(PHENO)_%_results.txt.gz $(TMPDIR)/%_rsid.txt.gz
	module load R
	Rscript --default-packages=tidyverse - <<-RSCRIPT
		read_tsv("$<") %>%
			left_join(read_tsv("$(lastword $^)")) %>%
			mutate(rsid=ifelse(is.na(rsid), MarkerName, rsid), ANNOT=1) %>%
			select(CHROM=chr, BEGIN=pos, END=pos, MARKER_ID=rsid, PVALUE=P, ANNOT) %>%
			arrange(CHROM, BEGIN) %>%
			write_tsv("$(TMPDIR)/$(basename $@)")
	RSCRIPT
	sed '1s/^/#/' $(TMPDIR)/$(basename $@) > $(basename $@)
	bgzip -f $(basename $@)
	-tabix -f -s 1 -b 2 -e 3 $@
		

$(TMPDIR)/$(SENTINEL)_rsid.txt.gz: 
	tabix -h $(SNP151) $(CHR):$(START)-$(END) | sed '1s/^#//' | gzip > $@

$(TMPDIR)/$(PHENO)_$(SENTINEL)_results.txt.gz: $(SMALL_METAL)
	zcat $(SMALL_METAL) | awk 'NR == 1 || ($$2 == $(CHR) && $$3 >= $(START) && $$3 <= $(END))' | gzip > $@


#$(EPACTS): chr$(CHR)/%_$(WAKEFIELD_CI).epacts.gz: chr$(CHR)/%_$(WAKEFIELD_CI).credible $(TMPDIR)/%_results_gc.txt.gz
#	module load tabix
#	awk -F '\t' 'BEGIN {
#		OFS = "\t"
#		print "#CHROM", "BEGIN", "END", "MARKER_ID", "PVALUE", "ANNOT"
#	}
#
#	NR == FNR {
#		credible[$$1] = 1
#	}
#
#	NR > FNR && FNR > 1 {
#		if ($$1 in credible)
#			annot = 1
#		else
#			annot = 0
#		print $$2, $$3, $$3, $$1, $$NF, annot
#	}' $< <(zcat $(lastword $^)) | sort -k 2 -n | bgzip > $@
#	-tabix -s 1 -b 2 -e 3 "$@"

#$(CREDIBLE): chr$(CHR)/%_$(WAKEFIELD_CI).credible: wakefield.R $(TMPDIR)/%_results_gc.txt.gz ../ld/%.ld
#	module load R
#	Rscript $^ $(WAKEFIELD_P) $(WAKEFIELD_CI) $(WAKEFIELD_W) $(WAKEFIELD_R2) > $@
#
##SNP	CHR	BP	ALLELE1	ALLELE0	A1FREQ	INFO	BETA	SE	CHISQ_BOLT_LMM	P_BOLT_LMM	CHISQ_GC	P_GC
#$(RESULTS_PRIMARY): $(TMPDIR)/%_results_gc.txt.gz: 
#	module load tabix
#	tabix -h ../../$(PHENO).results_gc.txt.gz $(CHR):$(START)-$(END) | bgzip > $@
#
##Chr	SNP	bp	refA	freq	b	se	p	n	freq_geno	bC	bC_se	pC
#$(RESULTS_SECONDARY): $(TMPDIR)/%_results_gc.txt.gz:
#	awk -F '\t' 'BEGIN {
#		OFS = "\t"
#		print "#SNP", "CHR", "BP", "BETA", "SE", "P_GC"
#	}
#	
#	NR > 1 && $$13 != "NA" {
#		print $$2, $$1, $$3, $$11, $$12, $$13
#	}' ../novel/secondary/$(PHENO)_$*.cma.cojo | bgzip > $@
#
#$(LD): ../ld/%.ld: region_plots_sentinels_$(P_DISC).txt
#	$(MAKE) -C ../ld $*.ld SENTINELS=../region_plots/$<
#
#region_plots_sentinels_$(P_DISC).txt: $(SIGNALS)
#	awk 'BEGIN {
#		OFS = "\t"
#		print "ID",	"rsid",	"chrom", "pos"
#	}
#
#	NR > 1 { 
#		ID = $$6"_"$$7"_"$$8
#		rsid = ($$6 !~ /^rs/ && $$6 !~ /Affx/ ? ID : $$6)
#		print ID, rsid, $$5, $$9
#	}' $< > $@

# MarkerName      Allele1 Allele2 Freq1   FreqSE  MinFreq MaxFreq Weight  Zscore  P-value Direction       HetISq  HetChiSq        HetDf   HetPVal
# 2_102066978_A_C a       c       0.0003  0.0000  0.0003  0.0003  10965.00        1.209   0.2265  ???????????????+??????????????????????????????????      0.0     0.000   0       1

$(SMALL_METAL): $(BIG_METAL)
	tr '_' '\t' < $< | awk 'BEGIN {
		OFS = "\t"
		print "MarkerName", "chr", "pos", "Amin", "Amax", "P"
	}
	
	NR > 1 {
		print $$1"_"$$2"_"$$3"_"$$4, $$1, $$2, $$3, $$4, $$11
	}' | gzip > $@
