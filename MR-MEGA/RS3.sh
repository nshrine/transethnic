#!/bin/bash

for i in original_files_as_downloaded/RS3/*.txt.gz; do
    ./filter.sh RS3 <(zcat $i) | gzip > RS3/`basename ${i} | sed 's/SW_.\+.txt.gz/filtered.txt.gz/'` &
done
