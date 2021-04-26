#!/bin/bash

for i in original_files_as_downloaded/FHS/lme2v.FHS*.gz; do
    ./filter.sh FHS <(zcat $i | sed -e 's/,,/,NA,NA/g' -e 's/,NA\([^,]\)/,\1/g' | tr ',' '\t' | awk -F '\t' 'BEGIN { OFS = "\t" }
    NR == 1 { print $0, "SNPID" } NR > 1 { print $0, $2"_"$3"_"($4 < $5 ? $4 : $5)"_"($5 > $4 ? $5 : $4) }') | gzip >| FHS/`basename ${i/EL_09172020/filtered}` &
done
