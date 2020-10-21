#!/bin/bash

module load julia

for i in original_files_as_downloaded/B58C/B58C-HRC_*txt.gz; do
    ./filter.sh B58C <(zcat $i) | ./addPvalue.jl B58C | gzip >| B58C/`basename ${i/_DPS_28052019/_filtered}` 
done
