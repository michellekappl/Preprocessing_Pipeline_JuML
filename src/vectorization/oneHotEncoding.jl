"""
    one_hot_encoding(x)

Create a one-hot-encoding out of given TokenizedNlpPipe

# Examples:
```julia-repl
julia> pipe = TokenizedNlpPipe([["I", "love", "Julia"], ["Julia", "is", "awesome"]])
julia> one_hot(pipe)
VectorizedNlpPipe([[[1, 0, 0, 0, 0], [0, 1, 0, 0, 0], [0, 0, 1, 0, 0]], [[0, 0, 1, 0, 0], [0, 0, 0, 1, 0], [0, 0, 0, 0, 1]]], Dict("I" => 1, "love" => 2, "Julia" => 3, "is" => 4, "awesome" => 5))
```
"""
function one_hot_encoding(pipe::TokenizedNlpPipe)::VectorizedNlpPipe
    vocab_dict = get_vocab_dict(pipe.vocabulary)
    tokens = Vector{Vector{Vector{Int}}}()
    length_vocab = length(pipe.vocabulary)

    for (i, doc) in enumerate(pipe.tokens)
        doc_tokens = Vector{Vector{Int}}()
        for word in doc
            word_vector = zeros(length_vocab)
            word_vector[vocab_dict[word]] = 1
            push!(doc_tokens, word_vector)
        end
        push!(tokens, doc_tokens)
    end

    return VectorizedNlpPipe(tokens, vocab_dict, pipe.labels)
end

export one_hot_encoding