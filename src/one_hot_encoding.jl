function one_hot(pipe :: TokenizedNlpPipe)
    """
    one_hot(x)

    Create a one-hot-encoding out of given TokenizedNlpPipe

    """

    vocab_dict = get_vocab_dict(pipe.vocabulary)
    tokens = []
    length_vocab = length(pipe.vocabulary)

    for (i, sentence) in enumerate(pipe.data)
        sentence_tokens = []
        for word in sentence
            word_vector = zeros(length_vocab)
            word_vector[vocab_dict[word]] = 1
            push!(sentence_tokens, word_vector)
        end
        push!(tokens, sentence_tokens)
    end

    return VectorizedNlpPipe(tokens=tokens, vocabulary=vocab_dict)
end

function get_vocab_dict(vocab)
    """
    get_one_hot_for_vocab(vocab)

    Create a Dict with idx in vector as values and words as keys

    """

    vocab_dict = Dict()
    for (i, word) in enumerate(vocab)
        vocab_dict[word] = i
    end
    return vocab_dict
end

export one_hot