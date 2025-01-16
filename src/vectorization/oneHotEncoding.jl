"""
    one_hot_encoding(x)

Create a one-hot-encoding out of given TokenizedNlpPipe

    #Examples:
    ```julia-repl
    julia> pipe = TokenizedNlpPipe([["I", "love", "Julia"], ["Julia", "is", "awesome"]])
    julia> one_hot(pipe)
    VectorizedNlpPipe([[[1, 0, 0, 0, 0], [0, 1, 0, 0, 0], [0, 0, 1, 0, 0]], [[0, 0, 1, 0, 0], [0, 0, 0, 1, 0], [0, 0, 0, 0, 1]]], Dict("I" => 1, "love" => 2, "Julia" => 3, "is" => 4, "awesome" => 5))
    ```
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