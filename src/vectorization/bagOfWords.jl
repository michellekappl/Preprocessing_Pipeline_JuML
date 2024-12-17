function bag_of_words(pipe::TokenizedNlpPipe)::VectorizedNlpPipe

    """
    bag_of_words(x)

    Create a bag-of-words-encoding out of given TokenizedNlpPipe

    """

    vocab_dict = get_vocab_dict(pipe.vocabulary)
    tokens = Vector{Vector{Int}}()
    length_vocab = length(pipe.vocabulary)

    for (i, doc) in enumerate(pipe.tokens)
        doc_tokens = Vector{Int}()
        doc_tokens = zeros(length_vocab)
        for word in doc
            doc_tokens[vocab_dict[word]] += 1
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