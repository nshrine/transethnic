#!/bin/bash

module load julia 

for i in original_files_as_downloaded/RS1/*.txt.gz; do
    ./filter.sh RS1 <(zcat $i) | ./addPvalue.jl RS1 | gzip > RS1/`basename ${i} | sed 's/SW_.\+.txt.gz/filtered.txt.gz/'` &
done
