function dna2dummy(dna_string::String; F=FloatType)
    v = Array{F,1}(undef, 4*length(dna_string));
    for (index, alphabet) in enumerate(dna_string)
        start = (index-1)*4+1;
        v[start:start+3] = dummy[uppercase(alphabet)];
    end
    return v
end


"""
    data_2_dummy(dna_strings::Vector{String}; F=FloatType)
Turn a fasta file of DNA sequences to dummy encoded array; assumes each sequence in the fasta is the same length.

Input:
* `dna_strings`: A vector of strings 

Output:
    A matrix of type `FloatType` (e.g., Float32) where each column corresponds to the dummy encoded string in the fasta file.
"""
function data_2_dummy(dna_strings::Vector{String}; F=FloatType)
    how_many_strings = length(dna_strings);
    @assert how_many_strings != 0 "There aren't DNA strings found in the input";
    _len_ = length(dna_strings[1]); # assume length of each dna string in data is the same
    _S_ = Array{F, 2}(undef, (4*_len_, how_many_strings));
    for i = 1:how_many_strings
        length(dna_strings[i]) == _len_ && (@inbounds _S_[:, i] = dna2dummy(dna_strings[i]);)
    end
    return _S_
end