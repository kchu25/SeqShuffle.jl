const FloatType=Float32;

# dummy reference
const dummy = Dict('A'=>Array{FloatType}([1, 0, 0, 0]), 
                   'C'=>Array{FloatType}([0, 1, 0, 0]),
                   'G'=>Array{FloatType}([0, 0, 1, 0]), 
                   'T'=>Array{FloatType}([0, 0, 0, 1]));

const alphabets = ('A','C','G','T');
const alphabets_pos = Dict('A'=>1, 'C'=>2, 'G'=>3, 'T'=>4);
const pair_pos = Dict("AA"=>(1,1), "AC"=>(1,2), "AG"=>(1,3), "AT"=>(1,4),
                "CA"=>(2,1), "CC"=>(2,2), "CG"=>(2,3), "CT"=>(2,4),
                "GA"=>(3,1), "GC"=>(3,2), "GG"=>(3,3), "GT"=>(3,4),
                "TA"=>(4,1), "TC"=>(4,2), "TG"=>(4,3), "TT"=>(4,4));       