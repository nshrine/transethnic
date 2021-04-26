#!/bin/bash

for i in original_files_as_downloaded/ALHS/alhs_*txt.gz; do
    ./filter.sh ALHS <(zcat $i) | gzip >| ALHS/`basename ${i} | sed 's/_awjj_.\+\.chr_pos_All_rsq_snpid_final/_filtered/'` &
done
