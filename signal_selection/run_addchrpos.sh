#!/bin/bash

#PBS -N addchrpos
#PBS -j oe
#PBS -o log
#PBS -l walltime=23:0:0
#PBS -l pvmem=150gb
#PBS -d .

make addchrpos PHENO=${PHENO}
