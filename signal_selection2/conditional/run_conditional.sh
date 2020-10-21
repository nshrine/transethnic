#!/bin/bash

#PBS -N cond
#PBS -j oe
#PBS -o log
#PBS -l walltime=12:0:0
#PBS -l pvmem=12gb
#PBS -d .

i=$PBS_ARRAYID

make LOCUS=locus$i CHR=$CHR PHENO=$PHENO ROUND=$ROUND
