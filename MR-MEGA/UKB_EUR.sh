#!/bin/bash

for i in original_files_as_downloaded/UKB_EUR/*bgen.stats.gz; do
    ./filter.sh UKB_EUR <(zcat $i) | sed 's/^23_/X_/' | gzip > UKB_EUR/`basename ${i/bgen.stats/filtered}` &
done
