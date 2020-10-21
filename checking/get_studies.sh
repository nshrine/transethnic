#!/bin/bash

BASE=/scratch/gen1/agib1/trans-ethnic/raw/big_METAL
PHENO=FF
SNP=rs13141641

grep "Input File" ${BASE}/${PHENO}_big_METAL_results1.tbl.info | cut -f 8 -d '/' > ${PHENO}.studies
