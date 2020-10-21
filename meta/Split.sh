#!/bin/bash

for i in original_files_as_downloaded/Split/*res_rnk*; do
    ./filter.sh Split <(zcat $i) | gzip >| Split/`basename ${i/nomono_I4.out.adj/filtered.txt}` &
done
