#!/bin/bash

#PBS -N metal
#PBS -j oe
#PBS -o log
#PBS -l walltime=23:0:0
#PBS -l pvmem=128gb
#PBS -d .

metal $METAL
