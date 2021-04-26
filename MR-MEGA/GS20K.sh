#!/bin/bash


for i in original_files_as_downloaded/GS20K/*all*; do
    ./filter.sh GS20K <(zcat $i) | gzip >| GS20K/`basename ${i/ch_22052017/filtered}` &
done
