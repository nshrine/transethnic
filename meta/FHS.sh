#!/bin/bash

for i in original_files_as_downloaded/FHS/FHS*_all_*.gz; do
    ./filter.sh FHS <(zcat $i | sed -e 's/,,/,NA,NA/g' -e 's/,NA\([^,]\)/,\1/g' | tr ',' '\t') | gzip >| FHS/`basename ${i/EL_07172019/filtered}` &
done
