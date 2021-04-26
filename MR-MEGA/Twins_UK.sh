#!/bin/bash

for a in 28_49y 50_59y over_60y; do
    for i in original_files_as_downloaded/Twins_UK/*_${a}_*KP_30092019.txt.gz; do
        N=`awk '$1 == "'$a'" { print $2 }' original_files_as_downloaded/Twins_UK/sample_sizes.txt`
        ./filter.sh Twins_UK <(zcat $i | awk 'BEGIN { OFS = "\t" } NR == 1 { print $0, "N" } NR > 1 { print $0, '$N' }') | gzip > Twins_UK/`basename ${i/KP_30092019/filtered}` &
    done
done

#./filter.sh Twins_UK <(zcat original_files_as_downloaded/Twins_UK/Twins.UK_FEV1_adjusted_smk_CHR1_22.txt.gz) | ./addPvalue.jl Twins_UK | gzip >| Twins_UK/Twins.UK_FEV1_adjusted_smk_CHR1_22_filtered.txt.gz &
#./filter.sh Twins_UK <(zcat original_files_as_downloaded/Twins_UK/Twins.UK_FEV1_FVC_adjusted_smk_CHR1_22_30092019.txt.gz) | gzip >| Twins_UK/Twins.UK_FEV1_FVC_adjusted_smk_CHR1_22_filtered.txt.gz &
