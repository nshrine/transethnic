#!/usr/bin/awk -f

BEGIN {
    OFS = "\t"

    col["FEV1"] = 2
    col["FVC"] = 3
    col["FF"] = 4
    col["PEF"] = 5

    while (getline < "units.txt") {
        if ($1 == cohort) {
            units = $col[pheno]
            break
        }
    }

    if (!units) {
        print cohort" not found" > "/dev/stderr"
        exit
    }
}

# MARKERNAME      EA      NEA     BETA    SE      EAF     N       CHROMOSOME      POSITION        PVALUE
NR == 1 && $1 == "MARKERNAME" {
    snp = 1
    ea = 2
    nea = 3
    beta = 4
    se = 5
    eaf = 6
    n = 7
    chr = 8
    pos = 9
    p = 10
    print
    next
}

# Chromosome      Position        MarkerName      Allele1 Allele2 Freq1   FreqSE  Effect  StdErr  P-value Direction       TotalN
NR == 1 && $1 == "Chromosome" {
    snp = 3
    ea = 4
    nea = 5
    beta = 8
    se = 9
    eaf = 6
    n = 12
    chr = 1
    pos = 2
    p = 10
    print "MARKERNAME", "EA", "NEA", "BETA", "SE", "EAF", "N", "CHROMOSOME", "POSITION", "PVALUE"
    next
}

NR > 1 {
    if (((pheno == "FEV1" || pheno == "FVC") && units == "mL") || (pheno == "PEF" && units == "mL/sec")) {
        $beta = $beta / 1000
        $se = $se / 1000
    } else if (pheno == "FF" && units == "percent") {
        $beta = $beta / 100
        $se = $se / 100
    } else if (pheno == "PEF" && units == "L/min") {
        $beta = $beta / 60
        $se = $se /60
    }

    print $snp, toupper($ea), toupper($nea), $beta, $se, $eaf, $n, $chr, $pos, $p
}
