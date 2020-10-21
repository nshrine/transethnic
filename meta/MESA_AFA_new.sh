#!/bin/bash

for i in original_files_as_downloaded/MESA_AFA_new/*txt.gz; do
    ./filter.sh MESA_AFA_new <(zcat $i) | gzip >| MESA_AFA_new/`basename ${i/AWM_09112019/filtered}` &
done
