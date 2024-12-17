function one_hot_encoding(pipe::TokenizedNlpPipe)::VectorizedNlpPipe
    """
    one_hot(x)

    Create a one-hot-encoding out of given TokenizedNlpPipe

    """

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

    return VectorizedNlpPipe(tokens, vocab_dict)
end


function get_vocab_dict(vocab)
    """
    get_vocab_dict(vocab)

    Create a Dict with idx in vector as values and words as keys

    """

    vocab_dict = Dict{String, Int}()
    for (i, word) in enumerate(vocab)
        vocab_dict[word] = i
    end
    return vocab_dict
end

export one_hot_encoding