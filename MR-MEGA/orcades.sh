#!/bin/bash

#for i in original_files_as_downloaded/orcades/orcades_{FEV1,FVC,FF}_untransformed_all_CHRX_all_SMW_26042021.tsv.gz; do
#    ./filter.sh orcades <(zcat $i) | gzip > orcades/`basename ${i/CHRX_all_SMW_26042021/filtered}` &
#done

for i in original_files_as_downloaded/orcades/orcades_PEF_untransformed_{smk,nonsmk}_CHRX_all_SMW_26042021.tsv.gz; do
    ./filter.sh orcades <(zcat $i) | gzip > orcades/`basename ${i/CHRX_all_SMW_26042021/filtered}` &
done
