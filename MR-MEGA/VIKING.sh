#!/bin/bash

# viking_fev1_untransformed_20_29y_chr1_22_smw_31112019.tsv.gz

for f in original_files_as_downloaded/VIKING/*_smw_31112019.tsv.gz; do
    ./filter.sh VIKING <(zcat $f) | gzip >| VIKING/`basename $f | sed 's/smw_31112019/filtered/'` &
done

module load julia 

./filter.sh VIKING_PEF <(zcat original_files_as_downloaded/VIKING/VIKING_PEF_untransformed_chr1_22_kak_26052017.txt.gz) | \
    ./addPvalue.jl VIKING_PEF | gzip >| VIKING/VIKING_PEF_untransformed_chr1_22_filtered.txt.gz
