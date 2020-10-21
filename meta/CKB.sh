#!/bin/bash

for i in original_files_as_downloaded/CKB/*_CKB_{smk,nonsmk}_*.gz; do
    ./filter.sh CKB <(zcat $i) | gzip >| CKB/`basename ${i/AP_20022020/filtered.txt}` &
done
