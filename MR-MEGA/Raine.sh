#!/bin/bash

for i in original_files_as_downloaded/Raine/*.txt.gz; do
    ./filter.sh Raine <(zcat $i) | gzip > Raine/`basename ${i/CW_08092020/filtered}` &
done
