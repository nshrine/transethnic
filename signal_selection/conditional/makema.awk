#!/usr/bin/awk -f

BEGIN {
    OFS = "\t"
}

NR == 1 { 
    print "SNP", "A1", "A2", "freq", "b", "se", "p", "n"
}

FNR == 1 {
    for (i = 1; i<= NF; i++)
        col[$i] = i
    format = $1
    next
}


# filtered_rsid output
# rsid    unique_rsid     chr     pos     otherallele     effectallele    eaf     maf     mac     info    n       beta    se      p

# T output
# arkerame      llele1 llele2 req1   reqS  inreq axreq Weight  Zscore  P-value Direction

function ztose(z, p, n) {
    return 1/sqrt(2*p*(1-p)*(n+z^2))
}

function ztobeta(z, p, n) {
    return z*ztose(z, p, n)
}

format ~ /rsid/ {
    zscore = format == "unique_rsid"

    if (zscore && $col["Zscore"] == 0)
        next

    if ($col["eaf"] <= 0 || $col["eaf"] >= 1)
        next

    print $col["unique_rsid"], toupper($col["effectallele"]), toupper($col["otherallele"]), $col["eaf"],
          (zscore ? ztobeta($col["Zscore"], $col["eaf"], $col["n"]) : $col["beta"]),
          (zscore ? ztose($col["Zscore"], $col["eaf"], $col["n"]) : $col["se"]),
          $col["p"], $col["n"]
    next
}

format == "MarkerName" {

    if ($col["Zscore"] == 0 || $col["Freq1"] <= 0 || $col["Freq1"] >= 1)
        next

    print $col["MarkerName"], toupper($col["Allele1"]), toupper($col["Allele2"]), $col["Freq1"],
          ztobeta($col["Zscore"], $col["Freq1"], $col["Weight"]),
          ztose($col["Zscore"], $col["Freq1"], $col["Weight"]),
          $col["P-value"], $col["Weight"]
}
