#!/bin/bash

for i in original_files_as_downloaded/SAPALDIA_Edinburgh/*_AJ_16092020.txt.gz; do
    ./filter.sh SAPALDIA_Edinburgh <(zcat $i | awk 'BEGIN { OFS = "\t" } NR == 1 { print $0, "NONREF"; next } { print $0, ($6 == $4 ? $5 : $4) }') \
        | gzip > SAPALDIA_Edinburgh/`basename ${i/AJ_16092020/filtered}` &
done
