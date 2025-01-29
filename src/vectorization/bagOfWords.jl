"""
    bag_of_words(pipe::TokenizedNlpPipe) -> VectorizedNlpPipe

Create a bag-of-words-encoding out of given TokenizedNlpPipe

# Arguments
- `pipe::TokenizedNlpPipe`: The input `TokenizedNlpPipe` object containing the tokenized documents.

# Returns
- `VectorizedNlpPipe`: A new `VectorizedNlpPipe` object with the bag-of-words vectors.

# Example Usage
```jldoctest repl
julia> NlpPipe(["words one", "words two"]) |> tokenize |> bag_of_words
VectorizedNlpPipe{Int64}([[0 1 1], [1 0 1]], Dict("two" => 1, "one" => 2, "words" => 3), nothing)
```
---
"""
function bag_of_words(pipe::TokenizedNlpPipe)::VectorizedNlpPipe
    vocab_dict = get_vocab_dict(pipe.vocabulary)
    tokens = Vector{Matrix{Int}}()
    length_vocab = length(pipe.vocabulary)

    for doc in pipe.tokens
        doc_tokens = zeros(Int, 1, length_vocab)  # Create a matrix with 1 row and length_vocab columns
        for word in doc
            doc_tokens[1, vocab_dict[word]] += 1
        end
        push!(tokens, doc_tokens)
    end

    return VectorizedNlpPipe(tokens, vocab_dict, pipe.labels)
end

export bag_of_words