#!/usr/bin/awk -f

BEGIN {
    OFS = "\t"
}

NR == FNR && $1 == study {
   Chromosome=$5
   Position=$6
   effectallele=$7
   otherallele=$8
   EAF=$9
   beta=$10
   se=$11
   P=$12
   N=$13
   INFO=$14
   nextfile
}

NR > FNR && FNR == 1 {
    for (i = 1; i <= NF; i++)
        col[$i] = i
    $1 = $1
    sub("\r$", "", $0)
#    if (P == "NA")
#        $0 = $0"\tP"
    if (!("MAC" in col))
        $0 = $0"\tMAC"  
    if (col[P])
        print "MARKERNAME", "EA", "NEA", "BETA", "SE", "EAF", "N", "CHROMOSOME", "POSITION", "PVALUE"
    else
        print "MARKERNAME", "EA", "NEA", "BETA", "SE", "EAF", "N", "CHROMOSOME", "POSITION"
    if (debug) {
        print "Chromosome:", Chromosome, "in col", col[Chromosome] > "/dev/stderr"
        print "Position:", Position, "in col", col[Position] > "/dev/stderr"
        print "effectallele:", effectallele, "in col", col[effectallele] > "/dev/stderr"
        print "otherallele:", otherallele, "in col", col[otherallele] > "/dev/stderr"
        print "EAF:", EAF, "in col", col[EAF] > "/dev/stderr"
        print "beta:", beta, "in col", col[beta] > "/dev/stderr"
        print "se:", se, "in col", col[se] > "/dev/stderr"
        print "N:", N, "in col", col[N] > "/dev/stderr"
        print "INFO:", INFO, "in col", col[INFO] > "/dev/stderr"
        print "Chromosome", "Position", "effectallele", "otherallele", "eaf", "beta", "se", "n", "mac", "info" > "/dev/stderr"
    }
}


NR > FNR && FNR > 1 {
    eaf = $col[EAF]
    maf = eaf < 0.5 ? eaf : 1-eaf
    n = N ~ /^[0-9]+$/ ? N : $col[N]
    if ("MAC" in col) {
        mac = $col["MAC"]
    } else {
        mac = maf * 2 * n
        $0 = $0"\t"mac
    }
    # Convert any positions in scientific notation (e.g. from SAIGE) to integer
    if ($col[Position] ~ /e/)
        $col[Position] = sprintf("%d", $col[Position])
    if (debug)
        print $col[Chromosome], $col[Position], $col[effectallele], $col[otherallele], eaf, $col[beta], $col[se], n, mac, $col[INFO] > "/dev/stderr"
}

NR > FNR && FNR > 1 && tolower($col[beta]) !~ /na/ && ($col[beta] + 0 != 0) && tolower($col[se]) !~ /na/ && ($col[se] + 0 != 0) && $col[EAF] !~ /NA/ && mac >= 3 && (INFO == "NA" || $col[INFO] >= 0.3) {
    $1 = $1
    a[1] = $col[effectallele]
    a[2] = $col[otherallele]
    asort(a)
    sub("^0", "", $col[Chromosome])
    unique_id = $col[Chromosome]"_"$col[Position]"_"a[1]"_"a[2]
    sub("\r$", "", $0)
#    if (P == "NA") {
#        z = $col[beta] / $col[se]
#        z = z > 0 ? -z : z
#        cmd = "./pnorm " z
#        cmd | getline p
#        close(cmd)
#        $0 = $0"\t"2*p
#    }
    if (col[P])
        print unique_id, $col[effectallele], $col[otherallele],$col[beta], $col[se], eaf, n, $col[Chromosome], $col[Position], $col[P]
    else 
        print unique_id, $col[effectallele], $col[otherallele],$col[beta], $col[se], eaf, n, $col[Chromosome], $col[Position]
}
