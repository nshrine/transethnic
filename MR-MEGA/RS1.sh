#!/bin/bash

for i in original_files_as_downloaded/RS1/*.txt.gz; do
    ./filter.sh RS1 <(zcat $i) | gzip > RS1/`basename ${i} | sed 's/SW_.\+.txt.gz/filtered.txt.gz/'` &
done
