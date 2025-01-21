using SnowballStemmer

"""
stemming(input) stems words to their origin, default language is english, we're using SnowballStemmer.jl
"""
function stemming(pipe::TokenizedNlpPipe; language::String="english")::TokenizedNlpPipe
    #create stemmer specified language
    stemmer = Stemmer(language)
    
    #do stemming to each word from input
    #stemmed_words = [stem(stemmer, word) for word in input]
    stemmed_data = Vector{Vector{String}}()
    for doc in pipe.tokens
        stemmed_doc = [stem(stemmer, word) for word in doc]
        push!(stemmed_data, stemmed_doc)
    end
    
    return TokenizedNlpPipe(pipe.corpus, stemmed_data, pipe.labels)
end

export stemming
