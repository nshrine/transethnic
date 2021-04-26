#!/bin/bash

awk 'BEGIN {
    OFS = "\t"
}

NR == 1 || FNR > 1 {
    sub("^X_", "23_", $1)
    sub("X", "23", $(NF - 2))
    print
}' <(zcat $1) <(zcat $2)
