#!/bin/bash

for i in original_files_as_downloaded/CHSEA/*csv.gz; do
    ./filter.sh CHSEA <(zcat $i | tr ',' '\t') | gzip >| CHSEA/`basename ${i/tmb_23092019_results.csv/filtered.txt}` &
done
