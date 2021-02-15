#!/bin/bash

#PBS -N checktrans
#PBS -j oe
#PBS -o log
#PBS -l walltime=2:0:0
#PBS -l pvmem=12gb
#PBS -d .

[ -d $COHORT ] || mkdir $COHORT
i=$PBS_ARRAYID
module load R
Rscript checktrans.R $COHORT $i
