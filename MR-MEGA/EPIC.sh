#!/bin/bash

for i in original_files_as_downloaded/EPIC/*; do
    ./filter.sh EPIC <(zcat $i | awk 'BEGIN { OFS = "\t" }
        NR == 1 { print $0, "EAF", "N" } NR > 1 { print $0, ($6 > $8 ? $9 : 1 - $9), $6 + $7 + $8 }') |
            gzip >| EPIC/`basename ${i} | sed 's/JHZ_.\+.txt.gz/filtered.txt.gz/'` &
done
