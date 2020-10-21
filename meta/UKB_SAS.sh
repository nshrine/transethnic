#!/bin/bash

for i in original_files_as_downloaded/UKB_SAS/*txt.gz; do
    ./filter.sh UKB_SAS <(zcat $i) | sed 's/^23_/X_/' | gzip > UKB_SAS/`basename ${i/NS_23042020/filtered}` &
done
