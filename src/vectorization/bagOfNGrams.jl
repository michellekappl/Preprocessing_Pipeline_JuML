"""
    bag_of_ngrams(pipe::TokenizedNlpPipe; n::Int = 1) -> VectorizedNlpPipe

Create a bag of n-grams out of given TokenizedNlpPipe, with padding for shorter documents.

# Arguments
- `pipe::TokenizedNlpPipe`: The input `TokenizedNlpPipe` object containing the tokenized documents.
- `n::Int: The n-gram size. Defaults to 1.

# Returns
- `VectorizedNlpPipe`: A new `VectorizedNlpPipe` object with the n-gram vectors.

# Example Usage
```jldoctest repl
julia> NlpPipe(["words one", "words two"]) |> tokenize |> bag_of_ngrams
VectorizedNlpPipe{Int64}([[1 0 0; 0 1 0], [1 0 0; 0 0 1]], Dict("two" => 3, "one" => 2, "words" => 1), nothing)
```
---
"""
function bag_of_ngrams(pipe::TokenizedNlpPipe; n::Int = 1)::VectorizedNlpPipe
    ngram_vocab = create_n_gram_dict(pipe, n)
    data_vector = Vector{Matrix{Int}}()
    length_vocab = length(ngram_vocab)

    for doc in pipe.tokens
        doc_vector = zeros(Int, 0, length_vocab)
        for i in 1:(length(doc) - n + 1)
            ngram = join(doc[i:(i + n - 1)], " ")
            ngram_vector = zeros(Int, length_vocab)
            ngram_vector[ngram_vocab[ngram]] = 1
            doc_vector = [doc_vector; ngram_vector']
        end
        push!(data_vector, doc_vector)
    end
    return VectorizedNlpPipe(data_vector, ngram_vocab, pipe.labels)
end

export bag_of_ngrams

"""
    create_n_gram_dict(pipe, n)

Create a dictionary of ngrams out of given TokenizedNlpPipe.

# Example Usage
# Example Usage
```
julia> pipe = TokenizedNlpPipe([["one", "sentence", "sample"],["two", "sentence", "sample"]])
julia> create_n_gram_dict(pipe, 2)
Dict("two sentence" => 2, "sentence sample" => 3, "one sentence" => 1)
```
"""

function create_n_gram_dict(pipe::TokenizedNlpPipe, n::Int)::Dict{String, Int}
    ngram_vocab = Dict{String, Int}()
    idx = 1

    for doc in pipe.tokens
        if length(doc) < n
            padding = fill("<PAD>", n - length(doc))
            push!(doc, padding...)
        end
        for i in 1:(length(doc) - n + 1)
            ngram = join(doc[i:(i + n - 1)], " ")
            if !haskey(ngram_vocab, ngram)
                ngram_vocab[ngram] = idx
                idx += 1
            end
        end
    end

    return ngram_vocab
end


