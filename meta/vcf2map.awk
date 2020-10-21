#!/usr/bin/awk -f

BEGIN {
    OFS = "\t"
}

$1 ~ /^##/ {
    NR = NR - 1
    next
}

NR == 1 {
    print "CHR", "BP", "rsid", "Amin", "Amax"
    next
}

{
    split($5, alt, ",")
 
    for (i in alt) {
        allele[1] = $4
        allele[2] = alt[i]
        asort(allele)
        print $1, $2, $3, allele[1], allele[2]
    }
}
