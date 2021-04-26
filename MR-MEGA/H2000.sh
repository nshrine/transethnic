#!/bin/bash

#for i in original_files_as_downloaded/H2000/*txt.gz; do
#    paste <(zcat $i) <(zcat ${i/txt/txt.afreq} | cut -f 5) | gzip >| H2000/`basename $i`
#done


# H2000/H2000_FEV1_untransformed_30-39y_CHR1_jk_12022020.txt.gz
# H2000/H2000_FEV1_untransformed_40-49y_CHR1_jk_12022020.txt.gz
# H2000/H2000_FEV1_untransformed_50-59y_CHR1_jk_12022020.txt.gz
# H2000/H2000_FEV1_untransformed_over60_CHR1_jk_12022020.txt.gz


#for p in FEV1 FVC FF; do
#    for a in 30-39y 40-49y 50-59y over60; do
#        infile=H2000/H2000_${p}_untransformed_${a}_CHR{1..22}_jk_12022020.txt.gz
#        outfile=H2000/H2000_${p}_untransformed_${a}_CHR1_22_filtered.txt.gz
#        ./filter.sh H2000 <(eval zcat $infile | awk 'NR == 1 || $1 != "#CHROM"' | ./fixH2000alleles.awk) | gzip >| $outfile
#    done 
#done

for i in H2000/H2000_*_CHRX_jk_*.txt.gz; do
    ./filter.sh H2000 <(zcat $i | ./fixH2000alleles.awk) | gzip >| H2000/`basename ${i} | sed 's/jk_.\+.txt.gz/filtered.txt.gz/'`
done
