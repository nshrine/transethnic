#!/bin/bash

# ARIC_EA_FF_smk_CHR14_untransformed_mrb_08092020.txt.gz

#for p in FEV1 FVC FF; do
#    for s in smk nonsmk; do
#        ./filter.sh ARIC_EA <(zcat original_files_as_downloaded/ARIC_EA/ARIC_EA_${p}_${s}_CHR{1..22}_untransformed_mrb_08092020.txt.gz) | \
#            gzip >| ARIC_EA/ARIC_${p}_${s}_CHR1_22_filtered.txt.gz
#    done
#done

 for s in smk nonsmk; do
             ./filter.sh ARIC_EA <(zcat original_files_as_downloaded/ARIC_EA/ARIC_EA_PEFR_${s}_CHR{1..22}_untransformed_mrb_11092020.txt.gz) | \
                             gzip >| ARIC_EA/ARIC_PEFR_${s}_CHR1_22_filtered.txt.gz
                 done

