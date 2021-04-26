#!/bin/bash

for i in original_files_as_downloaded/Korcula/korcula_{fev,fvc,fev_fvc,pef}_res_HRC.r1-1_nomono_I4.out.adj.gz; do
    ./filter.sh Korcula <(zcat $i) | gzip >| Korcula/`basename ${i/res_HRC.r1-1_nomono_I4.out.adj/filtered.txt}` &
done
