#!/bin/bash

#PBS -N cond
#PBS -j oe
#PBS -o log
#PBS -l walltime=12:0:0
#PBS -l pvmem=12gb
#PBS -d .

i=$PBS_ARRAYID

LOCUS=`awk 'NR == '$i' + 1 { print $1 }' ../${PHENO}_chr${CHR}_loci.txt`

make LOCUS=$LOCUS CHR=$CHR PHENO=$PHENO ROUND=$ROUND
