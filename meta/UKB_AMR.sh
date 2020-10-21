#!/bin/bash

for i in original_files_as_downloaded/UKB_AMR/*txt.gz; do
    ./filter.sh UKB_AMR <(zcat $i) | sed 's/^23_/X_/' | gzip > UKB_AMR/`basename ${i/NS_23042020/filtered}` &
done
