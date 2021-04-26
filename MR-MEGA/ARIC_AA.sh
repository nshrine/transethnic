#!/bin/bash

for i in original_files_as_downloaded/ARIC_AA/*txt.gz; do
    ./filter.sh ARIC_AA <(zcat $i) | gzip >| ARIC_AA/`basename ${i/_mrb/_filtered}` &
done
