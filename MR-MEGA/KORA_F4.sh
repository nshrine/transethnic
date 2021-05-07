#!/bin/bash

for i in original_files_as_downloaded/KORA_F4/*; do
    ./filter.sh KORA_F4 <(zcat $i) | gzip >| KORA_F4/`basename $i | sed 's/CF_05022021/filtered/'` &
done
