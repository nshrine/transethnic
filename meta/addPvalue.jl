#!/usr/bin/env julia

using Distributions

const d = Normal()
const study = ARGS[1]

beta_col = String
se_col = String

for line in eachline("descriptives_cols.tsv")
    cols = split(line)
    if (cols[1] == study)
        global beta_col = cols[10]
        global se_col = cols[11]
        break
    end
end


firstline = true
beta_idx = 0::Integer
se_idx = 0::Integer

for line in eachline()
    cols = split(line)
    if (firstline)
        global beta_idx = findfirst(isequal(beta_col), cols)
        global se_idx = findfirst(isequal(se_col), cols)
        println(line * "\tP")
        global firstline = false
    else
        P = try
            beta = parse(Float64, cols[beta_idx])
            se = parse(Float64, cols[se_idx])
            2*cdf(d, -abs(beta/se))
        catch e
            NaN
        end
        println(line, "\t",  round(P, sigdigits=5))
    end
end
