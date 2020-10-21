#!/bin/bash

for i in original_files_as_downloaded/UKB_EUR/*txt.gz; do
    ./filter.sh UKB_EUR <(zcat $i) | sed 's/^23_/X_/' | gzip > UKB_EUR/`basename ${i/NS_23042020/filtered}` &
done
