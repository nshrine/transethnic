#!/bin/bash

for i in original_files_as_downloaded/SAPALDIA_Gabriel/*_AJ_02032020.txt.gz; do
    ./filter.sh SAPALDIA_Gabriel <(zcat $i | awk 'BEGIN { OFS = "\t" } NR == 1 { print $0, "NONREF"; next } { print $0, ($6 == $4 ? $5 : $4) }') \
        | gzip > SAPALDIA_Gabriel/`basename ${i/AJ_02032020/filtered}` &
done
