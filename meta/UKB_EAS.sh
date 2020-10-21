#!/bin/bash

for i in original_files_as_downloaded/UKB_EAS/*txt.gz; do
    ./filter.sh UKB_EAS <(zcat $i) | sed 's/^23_/X_/' | gzip > UKB_EAS/`basename ${i/NS_23042020/filtered}` &
done
