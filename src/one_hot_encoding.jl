function one_hot(data, vocab = [])
    """
    one_hot(x)

    Create a one-hot-encoding out of given vocabulary

    # Examples
    ```jldoctest
    julia> a = [["hello", "world"], ["second", "sentence"]]
    julia> one_hot(a)
    2×4 Array{Int64}:
     1  1  0  0
     0  0  1  1
    ```
    """
    if length(vocab) == 0
        vocab = get_vocab(data)
    end
    vocab_dict = get_vocab_dict(vocab)
    one_hot_data = zeros(Int, length(data), length(vocab))
    for (i, sentence) in enumerate(data)
        for word in sentence
            one_hot_data[i, vocab_dict[word]] = 1
        end
    end
    return one_hot_data
end

function get_vocab(data)
    """
    get_vocab(data)

    Get the vocabulary from the data

    # Examples
    ```jldoctest
    julia> a = [["hello", "world"], ["second", "sentence"]]
    julia> get_vocab(a)
    4-element Array{String}:
     "hello"
     "world"
     "second"
     "sentence"
    ```
    """
    vocab = []
    for sentence in data
        for word in sentence
            if word ∉ vocab
                push!(vocab, word)
            end
        end
    end
    return vocab
end

function get_vocab_dict(vocab)
    """
    get_one_hot_for_vocab(vocab)

    Create a Dict with idx in vector as values and words as keys

    # Examples
    ```jldoctest
    julia> a = ["hello", "world", "second", "sentence"]
    julia> get_one_hot_for_vocab(a)
    Dict("hello" => 1, "world" => 2, "second" => 3, "sentence" => 4)
    ```
    """
    vocab_dict = Dict()
    for (i, word) in enumerate(vocab)
        vocab_dict[word] = i
    end
    return vocab_dict
end

export one_hot