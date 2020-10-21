#!/usr/bin/awk -f

NR == FNR {
    meta[$1]
    next
}

# MarkerName      Allele1 Allele2 Freq1   FreqSE  Weight  Zscore  P-value Direction
FNR > 1 && $1 in meta {
    SNPID="MarkerName"
    effectallele="Allele1"
    otherallele="Allele2"
    EAF="Freq1"
    beta="Zscore"
    P="P-value"
    N="Weight"
}

FNR > 1 && !($1 in meta) {
    SNPID="unique_id"
    effectallele=$7
    otherallele=$8
    EAF=$9
    beta=$10
    P=$12
    sub("NA", "P", P)
    N=$13
}

FNR > 1 {
    print "#", $1
    print "MARKER", SNPID
    print "ALLELE", effectallele, otherallele
    print "FREQ", EAF
    print "EFFECT", beta
    print "PVALUE", P
    if (N + 0 > 0)
        print "DEFAULTWEIGHT", N
    else
        print "WEIGHT", N
    print ""
}
