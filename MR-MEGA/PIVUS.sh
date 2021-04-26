#!/bin/bash

module load julia 

for i in original_files_as_downloaded/PIVUS/*.txt.gz; do
    ./filter.sh PIVUS <(zcat $i) | ./addPvalue.jl PIVUS | gzip > PIVUS/`basename ${i/jpc_19072017/filtered}` &
done
