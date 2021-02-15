#!/bin/bash

n=`awk '$1 == "'$1'" { n++ } END { print n }' files.txt`
qsub -v COHORT=$i -t 1-$n
