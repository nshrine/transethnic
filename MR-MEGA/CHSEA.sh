#!/bin/bash

for i in original_files_as_downloaded/CHSEA/*csv.gz; do
    ./filter.sh CHSEA <(zcat $i | tr ',' '\t') | gzip >| CHSEA/`basename ${i/tmb_22092020_results.csv/filtered.txt}` &
done
