# SeqShuffle

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://kchu25.github.io/SeqShuffle.jl/dev)
[![Build Status](https://github.com/kchu25/SeqShuffle.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/kchu25/SeqShuffle.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/kchu25/SeqShuffle.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/kchu25/SeqShuffle.jl)

Shuffle a string such that it preserves the k-mer frequency in the string.

# Usage

```julia

    # an example string
    str = "CAGCCCCGCAGGCCACTGCCTCGCC";

    # shuffle the string such that it preserves the frequency of 2-mers
    seq_shuffle(str; k=2)
    > "CTGCCAGCCCCCAGCGCACGGCCTC"

    # shuffle the string such that it preserves the frequency of 3-mers
    seq_shuffle(str; k=3)
    > "CAGCCAGGCCGCACTGCCCCTCGCC"

    # shuffle every string in the fasta file such that it perserves the 
    # frequency of 2-mers in each string; save the result as a new fasta 
    # file output. Input and output are absolute filepaths as strings.     
    shuffle_fasta(fasta_location::String, fasta_output_location::String)
```
