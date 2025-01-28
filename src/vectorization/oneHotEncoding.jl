"""
    one_hot_encoding(pipe::TokenizedNlpPipe) -> VectorizedNlpPipe

Create a one-hot-encoding out of given TokenizedNlpPipe

# Parameters
- `pipe::TokenizedNlpPipe`: The input `TokenizedNlpPipe` object containing the tokenized documents.

# Returns
- The output `VectorizedNlpPipe` object containing the one-hot-encoded documents.

# Example Usage
```jldoctest repl
julia> NlpPipe(["words one", "words two"]) |> tokenize |> one_hot_encoding
VectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[0 0 1; 0 1 0], [0 0 1; 1 0 0]], Dict("two" => 1, "one" => 2, "words" => 3), nothing)
```
---
"""
function one_hot_encoding(pipe::TokenizedNlpPipe)::VectorizedNlpPipe
    vocab_dict = get_vocab_dict(pipe.vocabulary)
    tokens = Vector{Matrix{Int}}()
    for doc in pipe.tokens
        doc_matrix = zeros(Int, length(doc), length(vocab_dict))
        for (i, token) in enumerate(doc)
            doc_matrix[i, vocab_dict[token]] = 1
        end
        push!(tokens, doc_matrix)
    end

    return VectorizedNlpPipe(tokens, vocab_dict, pipe.labels)
end

export one_hot_encoding