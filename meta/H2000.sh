#!/bin/bash

for i in original_files_as_downloaded/H2000/*txt.gz; do
    paste <(zcat $i) <(zcat ${i/txt/txt.afreq} | cut -f 5) | gzip >| H2000/`basename $i`
done

for p in FEV1 FVC FF; do
    for s in smk nonsmk; do
        infile=H2000/H2000_${p}_${s}_CHR{1..22}_jk_*.txt.gz
        outfile=H2000/H2000_${p}_${s}_CHR1_22_filtered.txt.gz
        ./filter.sh H2000 <(eval zcat $infile | awk 'NR == 1 || $1 != "#CHROM"' | ./fixH2000alleles.awk) | gzip >| $outfile
    done 
done

for i in H2000/H2000_*_CHRX_*_jk_*.txt.gz; do
    ./filter.sh H2000 <(zcat $i | ./fixH2000alleles.awk) | gzip >| H2000/`basename ${i} | sed 's/jk_.\+.txt.gz/filtered.txt.gz/'`
done
