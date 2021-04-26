#!/bin/bash

awk 'BEGIN {
    OFS = "\t"
}

NR == 1 || FNR > 1 {
    sub("X", "23", $1)
    sub("^X_", "23_", $3)
    print
}' $1 $2
