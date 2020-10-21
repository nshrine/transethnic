sink(stderr())
library(tidyverse)

args <- commandArgs(T)
infile <- args[1]

#infile <- "B58C_FEV1_smk_CHR1_22_DPS_28052019.txt.gz"

#CHR     POS     NONEFFECT       EFFECT  N       EAF     BETA    SE_BETA IMP_RSQ GENO    VCFID
results <- read_tsv(infile, col_types = cols(CHR = "c", GENO = "-", VCFID = "-"))

results <- results %>%
    mutate(MAF = ifelse(EAF > 0.5, 1-EAF, EAF),
           MAC = MAF * 2 * N) 

results_filt <- results %>%
    filter(MAC >= 3 & IMP_RSQ >= 0.3)

#RS_id  Chromosome      Position        Allele1 Allele2 Minor_Allele    MAF     Info_score
mapping <- read_tsv("ukb_mfi_v3.txt.gz",
                    col_types = cols_only(`#RS_id` = "c",
                                          Chromosome = "c",
                                          Position = "i",
                                          Allele1 = "c",
                                          Allele2 = "c")) %>%
    mutate(Chromosome = ifelse(Chromosome %in% c("23", "25"), "X", Chromosome))

mapping <- mapping %>% 
    select(rsid=`#RS_id`, Chromosome, Position, Allele1, Allele2) %>%
    inner_join(results_filt %>% select(Chromosome=CHR, Position=POS))

mapping <- mapping %>%
    mutate(Amin=pmin(Allele1, Allele2), Amax=pmax(Allele1, Allele2)) %>%
    select(rsid, Chromosome, Position, Amin, Amax) %>%
    distinct

results_out <- results_filt %>%
    mutate(Amin=pmin(NONEFFECT, EFFECT), Amax=pmax(NONEFFECT, EFFECT)) %>%
    left_join(mapping, c("CHR" = "Chromosome", "POS" = "Position", "Amin", "Amax")) %>%
    mutate(rsid = paste(ifelse(grepl("^rs", rsid), rsid, paste(CHR, POS, sep="_")),
                        Amin, Amax, sep="_"),
           P = 2*pnorm(-abs(BETA/SE_BETA))) %>%
    select(-Amin, -Amax)

sink()
write.table(results_out, "", row.names=F, quote=F, sep="\t")
