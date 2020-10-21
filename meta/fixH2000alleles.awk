#!/usr/bin/awk -f

BEGIN {
    OFS = "\t"
}

NR == 1 {
    print $0, "NON_A1", "FREQ1"
}

NR > 1 {
    REF=$4
    ALT=$5
    A1=$6
    ALT_FREQS=$13

    NON_A1 = (A1 == ALT ? REF : ALT)
    FREQ1 = (A1 == ALT ? ALT_FREQS : 1 - ALT_FREQS)
    print $0, NON_A1, FREQ1
}
