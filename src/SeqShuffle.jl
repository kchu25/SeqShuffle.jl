module SeqShuffle

import Random 

export seq_shuffle

include("shuffle.jl")
include("fasta.jl")

"""
shuffle_fasta(input_fasta_location::String, 
              fasta_output_location::String;
              k::Int=2, seed=nothing,
              max_entries=1000000)

Shuffle each sequence in the input fasta file such that it preserves the 
frequency of the k-mers in each sequence.

Input:
* `input_fasta_location`: the absolute file path of the fasta file.
* `fasta_output_location`: the absolute file path of the output fasta file.
* `k`: k for k-mer frequency.
* `seed`: The seed for random number generator.
* `max_entries`: The max number of entries to take from the fasta file (from 1 to max_entries).

Output:
    An output fasta file specified as `fasta_output_location`. 
    It contains the shuffled version of the original fasta file. 

"""
function shuffle_fasta(fasta_location::String, 
                       fasta_output_location::String;
                       k::Int=2, seed=nothing,
                       max_entries=1000000)
    seqs = read_fasta(fasta_location; max_entries=max_entries);
    seqs_shuffled = seq_shuffle.(seqs; k=k, seed=seed);
    save_fasta(seqs_shuffled, fasta_output_location);
end



end
