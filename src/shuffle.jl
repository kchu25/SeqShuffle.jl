# convert string to ASCII codes
str2code(s::String) = Int8.(collect(s));

# convert ASCII code to string
code2str(c::Vector{Int8}) = String(UInt8.(c));

function seq_shuffle(seq::String; k=2, seed_num=nothing)
    @assert k ≥ 1 "k must be larger than or equal to 1"

    !isnothing(seed_num) && Random.seed!(seed_num);

    # convert the string to ASCII array
    arr = str2code(seq);
    if k == 1
        return code2str(Random.shuffle(arr));
    else
        arr_shortmers = fill(Int8(-1),(length(arr), k-1));
        for i = 1:(k-1)
            arr_shortmers[1:(size(arr,1)-i+1),i] = arr[i:end];
        end
        shortmers = sortslices(unique(arr_shortmers, dims=1), dims=1);        
        tokens = vcat([findall(x->x==e, eachrow(shortmers)) 
                        for e in eachrow(arr_shortmers)]...);

        shuf_next_inds = Vector{Vector{Int}}();
        for token = 1:size(shortmers,1)
            inds = findall(tokens .== token);
            push!(shuf_next_inds, inds .+ 1);
        end
        
        for t = 1:size(shortmers,1)
            inds = [i for i = 1:length(shuf_next_inds[t])];
            inds[1:end-1] = Random.shuffle(@view inds[1:end-1]);  # Keep last index same
            shuf_next_inds[t] = shuf_next_inds[t][inds];
        end

        counters = ones(Int, size(shortmers,1));
        
        # build the resulting array
        ind = 1;
        result = copy(tokens);
        for j = 2:length(tokens)
            t = tokens[ind];
            ind = shuf_next_inds[t][counters[t]];
            counters[t] += 1;
            result[j] = tokens[ind];
        end
        shuffled_arr = shortmers[result,1];
        return code2str(shuffled_arr);
    end
end