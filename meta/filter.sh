#!/bin/bash

./filter.awk -v study=$1 descriptives_cols.tsv $2
