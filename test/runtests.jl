using SeqShuffle
using Random
using Test

@testset "SeqShuffle.jl" begin

    # check that the frequency of k-mers is perserved
    for k = 2:10
        str = "CAGCCCCGCAGGCCACTGCCTCGCC";
        shuffled_str = seq_shuffle(str; k=k);
        d = Dict{String,Int}();
        for i = 1:length(str)-k+1
            haskey(d, str[i:i+k-1]) ? d[str[i:i+k-1]]+=1 : d[str[i:i+k-1]]=1;
        end
        d_s = Dict{String,Int}();
        for i = 1:length(shuffled_str)-k+1
            haskey(d_s, shuffled_str[i:i+k-1]) ? d_s[shuffled_str[i:i+k-1]]+=1 : d_s[shuffled_str[i:i+k-1]]=1;
        end    
        @test d == d_s
    end

    for _ = 1:20
        str = randstring(300); # random string
        for k = 2:10        
            shuffled_str = seq_shuffle(str; k=k);
            d = Dict{String,Int}();
            for i = 1:length(str)-k+1
                haskey(d, str[i:i+k-1]) ? d[str[i:i+k-1]]+=1 : d[str[i:i+k-1]]=1;
            end
            d_s = Dict{String,Int}();
            for i = 1:length(shuffled_str)-k+1
                haskey(d_s, shuffled_str[i:i+k-1]) ? d_s[shuffled_str[i:i+k-1]]+=1 : d_s[shuffled_str[i:i+k-1]]=1;
            end    
            @test d == d_s
        end
    end

    # strs = [randstring("ACGT", 110)];
    # acgt_freq, markov = est_1st_order_markov_bg(strs)
    # size(SeqShuffle.assign_bg_prob(strs, markov, acgt_freq),2) == 110;

    # str = uppercase("ggcccgggcgctggccgcagcgcgagtgcgtccgtgcgactcttccctgcGTCCCTCCCCTccggggcgggttctagaggtgcgcgtcatcctgcagcaataggcgtggcc")
    # acgt_freq, markov = est_1st_order_markov_bg([str]);
    # SeqShuffle.assign_bg_prob(strs, markov, acgt_freq)


end
