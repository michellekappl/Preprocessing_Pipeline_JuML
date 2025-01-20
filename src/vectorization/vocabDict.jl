"""
    get_vocab_dict(vocab)

Create a Dict with idx in vector as values and words as keys
"""

function get_vocab_dict(vocab)
    vocab_dict = Dict{String, Int}()
    for (i, word) in enumerate(vocab)
        vocab_dict[word] = i
    end
    return vocab_dict
end
