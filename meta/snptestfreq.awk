#!/usr/bin/awk -f

BEGIN { 
    OFS = "\t"
}

NR == 1 {
    $1 = $1
    print $0, "freqB"
}

NR > 1 {
    all_AB=$15
    all_BB=$16
    all_total=$18
    print $0, (all_total > 0 ? (all_AB + 2*all_BB)/(2*all_total) : "NA")
}
