"""
bag_of_ngrams(pipe, n)

Create a bag of n-grams out of given TokenizedNlpPipe

#Examples:
```julia-repl
julia> pipe = TokenizedNlpPipe([["one", "sentence", "sample"],["two", "sentence", "sample"]])
julia> bag_of_ngrams(pipe, 2)
VectorizedNlpPipe([[1 0 0 ; 0 1 0], [0 1 0 ; 0 0 1]], Dict("two sentence" => 2, "sentence sample" => 3, "one sentence" => 1))
```
"""
function bag_of_ngrams(pipe::TokenizedNlpPipe, n::Int)::VectorizedNlpPipe
    # Initialize the vocabulary dictionary and indexing
    ngram_vocab = Dict{String, Int}()
    idx = 1

    # Precompute document n-grams and build vocabulary
    document_ngrams = Vector{Vector{Int}}()

    for doc in pipe.tokens
        ngram_doc = Vector{Int}()

        for i in 1:(length(doc) - n + 1)
            ngram = join(doc[i:(i + n - 1)], " ")
            if !haskey(ngram_vocab, ngram)
                ngram_vocab[ngram] = idx
                idx += 1
            end
            push!(ngram_doc, ngram_vocab[ngram])
        end
        push!(document_ngrams, ngram_doc)
    end

    # Vectorize the n-grams for each document
    max_vocab_size = length(ngram_vocab)
    vectorized_ngrams = Vector{Matrix{Int}}()
    for ngram_doc in document_ngrams
        doc_matrix = zeros(Int, length(ngram_doc), max_vocab_size)  # Preallocate the document matrix
        for row in eachindex(ngram_doc)
            doc_matrix[row, ngram_doc[row]] = 1  # Mark the n-gram index as present
        end
        push!(vectorized_ngrams, doc_matrix)
    end

    return VectorizedNlpPipe(vectorized_ngrams, ngram_vocab)
end
