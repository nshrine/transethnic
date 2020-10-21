#!/bin/bash

for i in original_files_as_downloaded/QBB/*.txt.gz; do
    ./filter.sh QBB <(zcat $i) | gzip > QBB/`basename ${i/gt_22042020/filtered}` &
done
