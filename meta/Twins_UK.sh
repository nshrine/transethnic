#!/bin/bash

module load julia 

for i in original_files_as_downloaded/Twins_UK/*KP_300092019.txt.gz; do
    ./filter.sh Twins_UK <(zcat $i) | gzip > Twins_UK/`basename ${i/KP_300092019/filtered}` &
done

./filter.sh Twins_UK <(zcat original_files_as_downloaded/Twins_UK/Twins.UK_FEV1_adjusted_smk_CHR1_22.txt.gz) | ./addPvalue.jl Twins_UK | gzip >| Twins_UK/Twins.UK_FEV1_adjusted_smk_CHR1_22_filtered.txt.gz &
./filter.sh Twins_UK <(zcat original_files_as_downloaded/Twins_UK/Twins.UK_FEV1_FVC_adjusted_smk_CHR1_22_30092019.txt.gz) | gzip >| Twins_UK/Twins.UK_FEV1_FVC_adjusted_smk_CHR1_22_filtered.txt.gz &
