"""
    bag_of_words(x)

Create a bag-of-words-encoding out of given TokenizedNlpPipe

# Examples:
```julia-repl
julia> pipe = TokenizedNlpPipe([["I", "love", "Julia"], ["Julia", "is", "awesome"]])
julia> bag_of_words(pipe)
VectorizedNlpPipe([[1, 1, 1, 0, 0], [0, 0, 1, 1, 1]], Dict("I" => 1, "love" => 2, "Julia" => 3, "is" => 4, "awesome" => 5))
```
"""
function bag_of_words(pipe::TokenizedNlpPipe)::VectorizedNlpPipe
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

    return VectorizedNlpPipe(tokens, vocab_dict, pipe.labels)
end

export bag_of_words