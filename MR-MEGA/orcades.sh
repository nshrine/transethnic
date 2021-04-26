#!/bin/bash

for i in original_files_as_downloaded/orcades/*.tsv.gz; do
    ./filter.sh orcades <(zcat $i) | gzip > orcades/`basename ${i/smw_30112019/filtered}` &
done
