"""
    tf_idf(pipe::TokenizedNlpPipe; tf_weighting::String = "relative term frequency", idf_weighting::String="inverse document frequency") -> VectorizedNlpPipe

Compute the TF-IDF (Term Frequency-Inverse Document Frequency) representation of the tokenized documents in the given `pipe`.

# Arguments
- `pipe::TokenizedNlpPipe`: A pipeline containing tokenized documents.
- `tf_weighting::String`: The term frequency weighting scheme. Options are "relative term frequency" (default) and "raw term frequency".
- `idf_weighting::String`: The inverse document frequency weighting scheme. Options are "inverse document frequency" (default) and "smooth inverse document frequency".

# Returns
- `VectorizedNlpPipe`: A pipe object containing the TF-IDF vectorized representation of the documents.

# Example Usage
```julia
julia> NlpPipe(["words one", "words two"]) |> tokenize |> tf_idf
VectorizedNlpPipe{Float64}([[0.0 0.0 0.0; 0.0 0.35 0.0], [0.0 0.0 0.0; 0.0 0.0 0.35]], Dict("two" => 3, "one" => 2, "words" => 1), nothing)
```
---
"""
function tf_idf(pipe::TokenizedNlpPipe; tf_weighting::String = "relative term frequency", idf_weighting::String="inverse document frequency")::VectorizedNlpPipe
    vocab_dict = tf_idf_vocab(pipe)
    data_vector = Vector{Matrix{Float64}}()
    total_docs = length(pipe.tokens)

    for (i, doc) in enumerate(pipe.tokens)
        tf_matrix = tf(i, doc, vocab_dict, tf_weighting)
        idf_matrix = idf(doc, vocab_dict, total_docs, idf_weighting)
        tf_idf_matrix = tf_matrix .* idf_matrix
        push!(data_vector, tf_idf_matrix)
    end
    new_vocab_dict = Dict{String, Int}()
    for (word, named_tuple) in vocab_dict
        new_vocab_dict[word] = named_tuple.index
    end
    return VectorizedNlpPipe(data_vector, new_vocab_dict, pipe.labels)
end


"""
    tf(doc_i::Int, doc::Vector{String}, vocab_dict::Dict{String, NamedTuple{(:index, :doc_dict)}}, weighting::String)::Matrix{Float64}

Compute the term frequency (TF) matrix for a given document.

# Parameters
- `doc_i::Int`: The index of the document in the corpus.
- `doc::Vector{String}`: The tokenized document.
- `vocab_dict::Dict{String, NamedTuple{(:index, :doc_dict)}}`: The vocabulary dictionary with term indices and document frequency information.
- `weighting::String`: The term frequency weighting scheme. Options are "relative term frequency" and "raw term frequency".

# Returns
- `Matrix{Float64}`: The term frequency matrix for the document.

"""

function tf(doc_i::Int, doc::Vector{String}, vocab_dict::Dict{String, NamedTuple{(:index, :doc_dict)}}, weighting::String)::Matrix{Float64}
    doc_matrix = zeros(Float64, length(doc), length(vocab_dict))
    for (word_i,word) in enumerate(doc)
        if weighting == "relative term frequency"
            doc_matrix[word_i, vocab_dict[word].index] = vocab_dict[word].doc_dict[doc_i] / length(doc)
        elseif weighting == "raw term frequency"
            doc_matrix[word_i, vocab_dict[word].index] = vocab_dict[word].doc_dict[doc_i]
        end
    end
    return doc_matrix
end

"""
    idf(doc::Vector{String}, vocab_dict::Dict{String, NamedTuple{(:index, :doc_dict)}}, total_docs::Int, weighting::String)::Matrix{Float64}

Compute the inverse document frequency (IDF) matrix for a given document.

# Parameters
- `doc::Vector{String}`: The tokenized document.
- `vocab_dict::Dict{String, NamedTuple{(:index, :doc_dict)}}`: The vocabulary dictionary with term indices and document frequency information.
- `total_docs::Int`: The total number of documents in the corpus.
- `weighting::String`: The inverse document frequency weighting scheme. Options are "inverse document frequency" and "smooth inverse document frequency".

# Returns
- `Matrix{Float64}`: The inverse document frequency matrix for the document.

"""

function idf(doc::Vector{String}, vocab_dict::Dict{String, NamedTuple{(:index, :doc_dict)}}, total_docs::Int, weighting::String)::Matrix{Float64}
    doc_matrix = zeros(Float64, length(doc), length(vocab_dict))
    for (word_i,word) in enumerate(doc)
        if weighting == "inverse document frequency"
            doc_matrix[word_i, vocab_dict[word].index] = log(total_docs / length(vocab_dict[word].doc_dict))
        elseif weighting == "smooth inverse document frequency"
            doc_matrix[word_i, vocab_dict[word].index] = log(total_docs / (1 + length(vocab_dict[word].doc_dict))) +1
        end
    end
    return doc_matrix
end


"""
    tf_idf_vocab(pipe::TokenizedNlpPipe)::Dict{String, NamedTuple{(:index, :doc_dict)}}

Generate the vocabulary dictionary with term indices and document frequency information from the tokenized documents in the given `pipe`.

# Parameters
- `pipe::TokenizedNlpPipe`: A pipeline containing tokenized documents.

# Returns
- `Dict{String, NamedTuple{(:index, :doc_dict)}}`: The vocabulary dictionary with term indices and document frequency information.

"""

function tf_idf_vocab(pipe::TokenizedNlpPipe)::Dict{String, NamedTuple{(:index, :doc_dict)}}
    vocab_dict = Dict{String, NamedTuple{(:index, :doc_dict)}}()
    idx = 1
    for (i, doc) in enumerate(pipe.tokens)
        for word in doc
            if haskey(vocab_dict, word)
                if haskey(vocab_dict[word].doc_dict, i)
                    vocab_dict[word].doc_dict[i] += 1
                else
                    vocab_dict[word].doc_dict[i] = 1
                end
            else
                vocab_dict[word] = (index=idx, doc_dict=Dict(i => 1))
                idx += 1
            end
        end
    end
    return vocab_dict
end 
