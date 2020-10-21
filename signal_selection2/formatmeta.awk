#!/usr/bin/awk -f


#ID   CHR     BP      Allele1 Allele2 Freq1   MAF     MAC     Weight  Zscore  P
#rs367896724_A_AC        1       10177   A       AC      0.6167  0.3833  319848.5        417230  0.97    0.332

BEGIN { 
    OFS = "\t"
}

NR == 1 {
    for (i = 1; i <= NF; i++)
        col[$i] = i

    base = gensub(/.tbl$/, "", 1, FILENAME)

    for (i = 1; i <= 23; i++)
        print "#ID", "CHR", "BP", "Allele1", "Allele2", "Freq1", "MAF", "MAC", "Weight", "Zscore", "P" > base"_chr"i".tbl"
}

NR > 1 { 
    CHR = gensub(/_.+/, "", 1, $col["MarkerName"])
    BP = gensub(/[1-9][0-9]?_([1-9][0-9]+)_[^0-9]+$/, "\\1", 1, $col["MarkerName"])
    MAF = $col["Freq1"] < 0.5 ? $col["Freq1"] : 1 - $col["Freq1"]
    MAC = MAF * 2 * $col["Weight"]

    print $col["MarkerName"], CHR, BP, toupper($col["Allele1"]), toupper($col["Allele2"]), $col["Freq1"],
          MAF, MAC, $col["Weight"], $col["Zscore"], $col["P-value"] > base"_chr"CHR".tbl"
}
