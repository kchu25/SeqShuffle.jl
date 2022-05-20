# convert string to ASCII codes
str2code(s::String) = Int8.(collect(s));

# convert ASCII code to string
code2str(c::Vector{Int8}) = String(UInt8.(c));

"""
    seq_shuffle(seq::String; k=2, seed=nothing)
Shuffle the input string such that it preserves the frequency of k-max_entries

Input:
* `seq`: A string
* `k`: interger; k-mer frequency
Output:
    A shuffled version of the string `seq`
"""
function seq_shuffle(seq::String; k=2, seed=nothing)
    @assert isascii(seq) "Must be a ascii string"
    @assert k ≥ 1 "k must be larger than or equal to 1"

    !isnothing(seed) && Random.seed!(seed);

    # convert the string to ASCII array
    arr = str2code(seq);
    if k == 1
        return code2str(Random.shuffle(arr));
    else
        arr_shortmers = fill(Int8(-1),(length(arr), k-1));
        @inbounds for i = 1:(k-1)
            arr_shortmers[1:(size(arr,1)-i+1),i] = @view arr[i:end];
        end
        shortmers = sortslices(unique(arr_shortmers, dims=1), dims=1);   
        tokens = vcat([findall(x->x==e,  eachrow(shortmers)) 
                        for e in eachrow(arr_shortmers)]...);

        shuf_next_inds = Vector{Vector{Int}}();
        @inbounds for token = 1:size(shortmers,1)
            inds = findall(tokens .== token);
            push!(shuf_next_inds, inds .+ 1);
        end
        
        @inbounds for t = 1:size(shortmers,1)
            inds = [i for i = 1:length(shuf_next_inds[t])];
            inds[1:end-1] = Random.shuffle(@view inds[1:end-1]);  
            shuf_next_inds[t] = shuf_next_inds[t][inds];
        end

        counters = ones(Int, size(shortmers,1));
        
        ind = 1;
        result = copy(tokens);
        @inbounds for j = 2:length(tokens)
            t = tokens[ind]::Int;
            ind = shuf_next_inds[t][counters[t]]::Int;
            counters[t] += 1;
            result[j] = tokens[ind]::Int;
        end
        shuffled_arr = shortmers[result,1];
        return code2str(shuffled_arr);
    end
end