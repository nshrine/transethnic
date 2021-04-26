#!/bin/bash

for i in original_files_as_downloaded/QBB/*.txt.gz; do
    ./filter.sh QBB <(zcat $i) | gzip > QBB/`basename ${i/GT_03012021/filtered}` &
done
