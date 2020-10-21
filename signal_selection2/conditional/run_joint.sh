#!/bin/bash

#PBS -N joint
#PBS -j oe
#PBS -o log
#PBS -l walltime=12:0:0
#PBS -l pvmem=12gb
#PBS -d .

make joint LOCUS=$LOCUS CHR=$CHR PHENO=$PHENO ROUND=$ROUND
