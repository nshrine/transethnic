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
   P=($12 == "NA" ? "P" : $12)
   N=$13
   INFO=$14
   nextfile
}

NR == FNR {
    next
}

FNR == 1 {
   for (i = 1; i <= NF; i++)
       col[$i] = i
            
   metal = $0 == "MarkerName\tAllele1\tAllele2\tFreq1\tFreqSE\tWeight\tZscore\tP-value\tDirection"

   print "SNP", "A1", "A2", "freq", "b", "se", "p", "n"
            
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

   next
}

metal {
   z = $7
   p = $4
   if (p == 0 || p == 1)
       next
   n = $6
   se = 1/sqrt(2*p*(1-p)*(n+z^2))
   beta = z*se

   print $1, toupper($2), toupper($3), $4, beta, se, $8, $6
   next
}

$col["unique_id"] && $col[effectallele] && $col[otherallele] && $col[EAF] && $col[beta] && $col[se] && $col[P] && $col[N] {
   n = N ~ /^[0-9]+$/ ? N : $col[N]
   print $col["unique_id"], $col[effectallele], $col[otherallele], $col[EAF], $col[beta], $col[se], $col[P], n
}
