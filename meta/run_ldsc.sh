#!/bin/bash

#PBS -N ldsc
#PBS -o log
#PBS -j oe
#PBS -l walltime=23:0:0
#PBS -l pvmem=64gb
#PBS -d .

i=$PBS_ARRAYID
COHORT=`awk 'NR == '$i' + 1 { print $1 }' descriptives_cols.tsv`

make ${COHORT}/${COHORT}_${PHENO}_h2.log PHENO=$PHENO
