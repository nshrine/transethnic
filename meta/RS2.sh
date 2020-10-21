#!/bin/bash

module load julia 

for i in original_files_as_downloaded/RS2/*.txt.gz; do
    ./filter.sh RS2 <(zcat $i) | ./addPvalue.jl RS2 | gzip > RS2/`basename ${i} | sed 's/SW_.\+.txt.gz/filtered.txt.gz/'` &
done
