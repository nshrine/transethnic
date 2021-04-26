#!/bin/bash

for i in original_files_as_downloaded/MESA_CAU_new/*txt.gz; do
    ./filter.sh MESA_CAU_new <(zcat $i) | gzip >| MESA_CAU_new/`basename ${i} | sed 's/AWM_[0-9]\+.txt/filtered.txt/'` &
done
