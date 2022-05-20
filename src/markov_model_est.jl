
all_dna_pairs = join.(collect(permutations("ACGT", 2)));

alphabets = ('A','C','G','T');
alphabets_pos = Dict('A'=>1, 'C'=>2, 'G'=>3, 'T'=>4);
pair_pos = Dict("AA"=>(1,1), "AC"=>(1,2), "AG"=>(1,3), "AT"=>(1,4),
                "CA"=>(2,1), "CC"=>(2,2), "CG"=>(2,3), "CT"=>(2,4),
                "GA"=>(3,1), "GC"=>(3,2), "GG"=>(3,3), "GT"=>(3,4),
                "TA"=>(4,1), "TC"=>(4,2), "TG"=>(4,3), "TT"=>(4,4));                

"""
    est_1st_order_markov_bg(vec_str::Vector{Sting}; laplace=1; F=FloatType)

    Estimate the Markov matrix, e.g.,
            A   C   G   T       
        A  0.1 0.3 0.4 0.2 
        C  0.5 0.1 0.1 0.3
        G  0.2 0.2 0.2 0.4
        T  0.7 0.1 0.1 0.1
    in the (shuffled) background sequence.
    The rows and the columns are ordered in A, C, G, T.

    And estimate the initial distribution, e.g,
        A   C   G   T       
       0.2 0.2 0.3 0.3 
    The columns are ordered in A, C, G, T.

Input:
* `vec_str`: vector of strings
* `laplace`: pseudocounts to add (optional, default to 1)
* `F`: datatype of the estiamtes (optional, default to Float32)

Output:
    The estimated 4x4 markov matrix and 4x1 initial distribution.
"""
function est_1st_order_markov_bg(vec_str::Vector{String}; laplace=1, F=FloatType)
    singleton_count = Dict(k=>0 for k in alphabets);
    pair_counts = Dict(k=>0 for k in keys(pair_pos));
    @inbounds for v in vec_str
        len_v = length(v);
        for nuc_ind = 1:len_v
            singleton_count[v[nuc_ind]] += 1;
            len_v != nuc_ind && (pair_counts[@view v[nuc_ind:nuc_ind+1]]+=1;)            
        end
    end

    # estimation
    acgt_freq = fill(F(0), (4,));
    for (ind,a) in enumerate(alphabets)
        acgt_freq[ind] = laplace + singleton_count[a];
    end
    acgt_freq = acgt_freq ./ sum(acgt_freq);
    markov_mat = fill(F(0),(4,4));
    for k in keys(pair_pos)
        markov_mat[pair_pos[k][1], pair_pos[k][2]] = laplace + pair_counts[k];
    end
    markov_mat = markov_mat ./ sum(markov_mat, dims=2);
    return acgt_freq, markov_mat
end

function assign_bg_prob(vec_str::Vector{String}, markov_mat, acgt_freq)
    # assumes all strings are of the same length
    bg_mat = Matrix{F}(undef, (length(vec_str), length(vec_str[1])));
    for (ind_v, v) in enumerate(vec_str)
        for (ind_a, a) in enumerate(v)
            if ind_a == 1 
                bg_mat[ind_v, 1] = acgt_freq[alphabets_pos[a]];
            else
                pos = pair_pos[@view v[ind_a-1:ind_a]];
                bg_mat[ind_v, ind_a] = markov_mat[pos[1], pos[2]];
            end
        end
    end
    return bg_mat
end

# bg_prob = assign_bg_prob(vec_str, markov_mat, acgt_freq);