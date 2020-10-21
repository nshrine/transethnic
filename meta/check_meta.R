library(data.table)
nick <- fread("FEV1_1.tbl")
abril <- fread("/data/gen1/LF_HRC_transethnic/metal/big_METAL/FEV1_big_METAL_chr_pos_a1_a2_results1.tbl")
nick <- nick[, .(MarkerName, Allele1, Allele2 , Freq1, Weight, Zscore, P=`P-value` , Direction) ]
abril <- abril[, .(MarkerName, Allele1, Allele2 , Freq1, Weight, Zscore, P=`P-value` , Direction) ]
nick[ grepl("^X", MarkerName), MarkerName:=sub("^X", "23", MarkerName) ]
nick[ grepl("^Y", MarkerName), MarkerName:=sub("^Y", "24", MarkerName) ]
abril[ grepl("^NA", MarkerName), MarkerName:=sub("^NA", "24", MarkerName) ]
nick[, c("CHR", "POS", "Amin", "Amax") := tstrsplit(MarkerName, "_", type.convert=T) ]
abril[, c("CHR", "POS", "Amin", "Amax") := tstrsplit(MarkerName, "_", type.convert=T) ]
setkey(nick, CHR, POS, Amin, Amax)
setkey(abril, CHR, POS, Amin, Amax)
nick[, table(CHR) ]
abril[, table(CHR) ]
nick <- nick[ !grepl("<", MarkerName) ]
abril_not_nick <- abril[ ! nick ]
nick_not_abril <- nick[ ! abril ]
comp <- abril[ nick, nomatch=0 ]
comp[, `:=`(diffFreq=i.Freq1 - Freq1, diffW=i.Weight - Weight, diffZ=i.Zscore - Zscore, diffDir=i.Direction != Direction) ]
