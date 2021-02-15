#!/bin/bash

#PBS -N filter
#PBS -j oe
#PBS -o log
#PBS -l walltime=23:0:0
#PBS -l vmem=64gb
#PBS -l nodes=1:ppn=2
#PBS -d .

./${COHORT}.sh
