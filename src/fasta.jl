function reading(filepath::String, max_entries=max_num_read_fasta)
    # read the file
    reads = read(filepath, String);
    # process the fasta file to get the DNA part
    # rid of sequences that contains "n"
    dna_reads = Vector{String}();
    for i in split(reads, '>')
        if !isempty(i)
            this_read = join(split(i, "\n")[2:end]);        
            if !occursin("N", this_read) && !occursin("n", this_read)
                push!(dna_reads, this_read);
            end
        end
    end    
    dna_reads = length(dna_reads) > max_entries ? dna_reads[1:max_entries] : dna_reads;
    return dna_reads
end

"""
read_fasta(filepath;  max_entries=1000000)
Read a fasta file into a vector of strings

Input:
* `filepath`: A string that's the input fasta file's absolute filepath.
* `max_entries`: The max number of entries to take from the fasta file (from 1 to max_entries).
Output:
    A vector of strings that corresponds to the strings in the fasta file. All strings are in uppercase.
"""
function read_fasta(filepath::String; max_entries=1000000)::Vector{String}
    #= read a fasta file =#
    dna_reads = reading(filepath, max_entries);   
    # convert all DNA seqeunce to uppercase
    return [uppercase(i) for i in dna_reads]
end

function save_fasta(vec_str::Vector{String}, target_filename::String)
    open(target_filename,"w") do file
        for (ind,s) in enumerate(vec_str)
            write(file, string(">sequence_", string(ind),"\n"));
            write(file, string(s,"\n"))
        end
    end
end