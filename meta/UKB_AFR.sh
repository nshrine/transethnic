#!/bin/bash

for i in original_files_as_downloaded/UKB_AFR/*txt.gz; do
    ./filter.sh UKB_AFR <(zcat $i) | sed 's/^23_/X_/' | gzip > UKB_AFR/`basename ${i/NS_23042020/filtered}` &
done
