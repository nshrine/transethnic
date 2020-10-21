#!/bin/bash

for i in original_files_as_downloaded/hunt/hunt_FEV1_all_chr1-23_afh_31122019_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_FEV1_all_chrX_all_afh_31012020_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_FVC_nonsmk_chr1-23_afh_31122019_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_FVC_smk_chr1-23_afh_31122019_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_FVC_all_chrX_all_afh_31012020_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_FEV1FVC_nonsmk_chr1-23_afh_31122019_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_FEV1FVC_smk_chr1-23_afh_31122019_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_FEV1FVC_nonsmk_chrX_all_afh_31012020_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_FEV1FVC_smk_chrX_all_afh_31012020_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_PEF_all_chr1-23_afh_31122019_impQuality_samplesize.txt.gz \
    original_files_as_downloaded/hunt/hunt_PEF_all_chrX_all_afh_31012020_impQuality_samplesize.txt.gz; do
    ./filter.sh hunt <(zcat $i) | gzip > hunt/`basename $i | sed 's/afh_.\+_impQuality_samplesize/filtered/'`
done
