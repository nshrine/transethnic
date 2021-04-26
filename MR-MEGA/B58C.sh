#!/bin/bash

# B58C-HRC_PEF-untrans_nonsmk_CHR1-22_DPS_18092020.txt.gz.tbi

module load julia

for i in original_files_as_downloaded/B58C/B58C-HRC_*txt.gz; do
    ./filter.sh B58C <(zcat $i) | ./addPvalue.jl B58C | gzip >| B58C/`basename ${i/_DPS_18092020/_filtered}` 
done
