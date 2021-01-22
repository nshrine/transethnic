#!/bin/bash

#PBS -N regionP
#PBS -j oe
#PBS -o log
#PBS -l walltime=23:0:0
#PBS -l pvmem=4gb
#PBS -d .

i=$PBS_ARRAYID

make CHR=$i
