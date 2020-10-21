#!/bin/bash

module load julia

for i in original_files_as_downloaded/GS20K/*all*; do
    ./filter.sh GS20K <(zcat $i) | ./addPvalue.jl GS20K | gzip >| GS20K/`basename ${i/ch_22052017/filtered}` &
done
