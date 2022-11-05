module SeqShuffle

import Random 

export seq_shuffle,
       shuffle_fasta,
       assign_bg_prob,
       est_1st_order_markov_bg

include("constants.jl")
include("shuffle.jl")
include("fasta.jl")
include("encodings.jl")
include("markov_model_est.jl")

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
    A fasta file that contains the shuffled version of the input fasta file. 

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
