#!/bin/bash

#PBS -N metal
#PBS -o log
#PBS -j oe
#PBS -l walltime=23:0:0
#PBS -l pvmem=128gb
#PBS -d .

metal $METAL | tee ${METAL/.metal/.log}
