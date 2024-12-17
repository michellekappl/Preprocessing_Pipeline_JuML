function one_hot_encoding(pipe::TokenizedNlpPipe)
    """
    one_hot(x)

    Create a one-hot-encoding out of give data and vocabulary

    """

    vocab_dict = get_vocab_dict(pipe.vocabulary)
    tokens = Vector{Vector{Vector{Int}}}()
    length_vocab = length(pipe.vocabulary)

    for (i, sentence) in enumerate(pipe.tokens)
        sentence_tokens = Vector{Vector{Int}}()
        for word in sentence
            word_vector = zeros(length_vocab)
            word_vector[vocab_dict[word]] = 1
            push!(sentence_tokens, word_vector)
        end
        push!(tokens, sentence_tokens)
    end

    return VectorizedNlpPipe(tokens, vocab_dict)
end

function get_vocab_dict(vocab)
    """
    get_one_hot_for_vocab(vocab)

    Create a Dict with idx in vector as values and words as keys

    """

    vocab_dict = Dict{String, Int}()
    for (i, word) in enumerate(vocab)
        vocab_dict[word] = i
    end
    return vocab_dict
end

export one_hot_encoding