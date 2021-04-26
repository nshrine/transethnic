#!/bin/bash

for i in original_files_as_downloaded/Vis/*res_*; do
    ./filter.sh Vis <(zcat $i) | gzip >| Vis/`basename ${i/nomono_I4.out.adj/filtered.txt}` &
done
