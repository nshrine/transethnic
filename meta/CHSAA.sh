#!/bin/bash

for i in original_files_as_downloaded/CHSAA/*csv.gz; do
    ./filter.sh CHSAA <(zcat $i | tr ',' '\t') | gzip >| CHSAA/`basename ${i/tmb_23092019_results.csv/filtered.txt}` &
done
