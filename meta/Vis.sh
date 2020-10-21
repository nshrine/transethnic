#!/bin/bash

for i in original_files_as_downloaded/Vis/*res_rnk*; do
    ./filter.sh Vis <(zcat $i) | gzip >| Vis/`basename ${i/nomono_I4.out.adj/filtered.txt}` &
done
