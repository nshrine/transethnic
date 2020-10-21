#!/bin/bash

module load julia

for i in original_files_as_downloaded/EPIC/*; do
    ./filter.sh EPIC <(zcat $i) | ./addPvalue.jl EPIC | gzip >| EPIC/`basename ${i} | sed 's/JHZ_.\+.txt.gz/filtered.txt.gz/'` &
done
