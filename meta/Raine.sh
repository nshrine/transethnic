#!/bin/bash

for i in original_files_as_downloaded/Raine/*.txt.gz; do
    ./filter.sh Raine <(zcat $i) | gzip > Raine/`basename ${i/CW_26082019/filtered}` &
done
