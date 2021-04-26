#!/bin/bash

for i in original_files_as_downloaded/EXCEED/EXCEED_*_14032021.txt.gz; do
    ./filter.sh EXCEED <(zcat $i | sed '1s/SNPID //') | gzip >| EXCEED/`basename ${i/14032021/filtered}` &
done
