# SeqShuffle

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://kchu25.github.io/SeqShuffle.jl/dev)
[![Build Status](https://github.com/kchu25/SeqShuffle.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/kchu25/SeqShuffle.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/kchu25/SeqShuffle.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/kchu25/SeqShuffle.jl)



Shuffle a string such that it preserves the k-mer frequency in the string (k $\geq$ 1).


# Installation
To install SeqShuffle.jl use Julia's package manager:
```
pkg> add SeqShuffle
```

# Usage

```julia

using SeqShuffle

# an example string
str = "CAGCCCCGCAGGCCACTGCCTCGCC";

# shuffle the string such that it preserves the frequency of 2-mers
seq_shuffle(str; k=2)
> "CTGCCAGCCCCCAGCGCACGGCCTC"

# shuffle the string such that it preserves the frequency of 3-mers
seq_shuffle(str; k=3)
> "CAGCCAGGCCGCACTGCCCCTCGCC"

# k=1 is just the ordinary shuffle
seq_shuffle(str; k=1)
> "CGTTACCGCGCGGCCCACCCAGCCC"

# The shuffling is not restricted to DNA alphabets; other alphabets
# works as well
seq_shuffle("ababacraggrac"; k=2)
> "ababaggracrac"

# of course, you can use the dot syntax in Julia to shuffle every string in the vector
vec_str = ["GCCCCGCAGGCCACTG", "CGCAGGCCTG", "CGTTTTCGCCTCGAAAAG"];
seq_shuffle.(vec_str; k=2)
> 3-element Vector{String}:
  "GCCCCCGCAGGCACTG"
  "CGCCAGGCTG"
  "CCTCGAAAAGTTTTCGCG"

# shuffle every string in the fasta file such that it perserves the 
# frequency of 2-mers in each string; save the result as a new fasta 
# file output. Input and output are absolute filepaths as strings.     
# (optional) Use a fixed seed for reproducibility.
shuffle_fasta(fasta_location::String, 
                fasta_output_location::String;
                k=2, seed::Union{Nothing, Int}=1234)
                

```
