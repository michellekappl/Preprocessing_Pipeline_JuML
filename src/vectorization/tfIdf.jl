"""
    tf_idf_vectorizer(pipe::TokenizedNlpPipe, tf_weighting::String = "relative term frequency", idf_weighting::String="inverse document frequency")::VectorizedNlpPipe

    This function computes the TF-IDF (Term Frequency-Inverse Document Frequency) vectorization for a given tokenized NLP pipeline.

    Parameters:
function tfidf_vectorizer(pipe::TokenizedNlpPipe, tf_weighting::String = "relative term frequency", idf_weighting::String="inverse document frequency")::VectorizedNlpPipe
    vocab_dict = tfidf_vocab(pipe)
    - idf_weighting: String, the inverse document frequency weighting scheme to use ("inverse document frequency" or "smooth inverse document frequency").

    Returns:
    - VectorizedNlpPipe: The vectorized NLP pipeline with TF-IDF values.
"""

function tf_idf(pipe::TokenizedNlpPipe; tf_weighting::String = "relative term frequency", idf_weighting::String="inverse document frequency")::VectorizedNlpPipe
    vocab_dict = tf_idf_vocab(pipe)
    data_vector = Vector{Matrix{Float64}}()
    total_docs = length(pipe.tokens)

    for (i, doc) in enumerate(pipe.tokens)
        tf_matrix = tf(i, doc, vocab_dict, tf_weighting)
        idf_matrix = idf(doc, vocab_dict, total_docs, idf_weighting)
        tf_idf_matrix = tf_matrix .* idf_matrix
        push!(data_vector, tf_idf_matrix)
    end
    new_vocab_dict = Dict{String, Int}()
    for (word, named_tuple) in vocab_dict
        new_vocab_dict[word] = named_tuple.index
    end
    return VectorizedNlpPipe(data_vector, new_vocab_dict, pipe.labels)
end

function tf(doc_i::Int, doc::Vector{String}, vocab_dict::Dict{String, NamedTuple{(:index, :doc_dict)}}, weighting::String)::Matrix{Float64}
    doc_matrix = zeros(Float64, length(doc), length(vocab_dict))
    for (word_i,word) in enumerate(doc)
        if weighting == "relative term frequency"
            doc_matrix[word_i, vocab_dict[word].index] = vocab_dict[word].doc_dict[doc_i] / length(doc)
        elseif weighting == "raw term frequency"
            doc_matrix[word_i, vocab_dict[word].index] = vocab_dict[word].doc_dict[doc_i]
        end
    end
    return doc_matrix
end

function idf(doc::Vector{String}, vocab_dict::Dict{String, NamedTuple{(:index, :doc_dict)}}, total_docs::Int, weighting::String)::Matrix{Float64}
    doc_matrix = zeros(Float64, length(doc), length(vocab_dict))
    for (word_i,word) in enumerate(doc)
        if weighting == "inverse document frequency"
            doc_matrix[word_i, vocab_dict[word].index] = log(total_docs / length(vocab_dict[word].doc_dict))
        elseif weighting == "smooth inverse document frequency"
            doc_matrix[word_i, vocab_dict[word].index] = log(total_docs / (1 + length(vocab_dict[word].doc_dict))) +1
        end
    end
    return doc_matrix
end

function tf_idf_vocab(pipe::TokenizedNlpPipe)::Dict{String, NamedTuple{(:index, :doc_dict)}}
    vocab_dict = Dict{String, NamedTuple{(:index, :doc_dict)}}()
    idx = 1
    for (i, doc) in enumerate(pipe.tokens)
        for word in doc
            if haskey(vocab_dict, word)
                if haskey(vocab_dict[word].doc_dict, i)
                    vocab_dict[word].doc_dict[i] += 1
                else
                    vocab_dict[word].doc_dict[i] = 1
                end
            else
                vocab_dict[word] = (index=idx, doc_dict=Dict(i => 1))
                idx += 1
            end
        end
    end
    return vocab_dict
end 
