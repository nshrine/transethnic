#!/bin/bash

for i in original_files_as_downloaded/hunt/hunt_{FEV,FVC,FEV1FVC,PEF}_untransformed_all_chr1-23_afh_011020.txt.gz; do
    ./filter.sh hunt <(zcat $i | awk 'BEGIN { OFS ="\t" } NR == 1 { print $0, "Rsq" } NR > 1 { print $0, 1 }') | gzip > hunt/`basename $i | sed 's/afh_011020/filtered/'`
done
