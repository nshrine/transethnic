#!/bin/bash

for i in original_files_as_downloaded/CKB/CKB_All_{smk,nonsmk}*.gz; do
    ./filter.sh CKB <(zcat $i) | gzip >| CKB/`basename ${i/AP_08092020/filtered.txt}` &
done
