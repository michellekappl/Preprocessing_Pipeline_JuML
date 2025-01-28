using SnowballStemmer

"""
    stemming(pipe::TokenizedNlpPipe; language::String="english") -> TokenizedNlpPipe
 
    Reduces tokens to their roots by removing pre- and suffixes. These are provided by [SnowballStemmer.jl](https://docs.juliahub.com/General/SnowballStemmer/stable/).

 # Arguments
- `pipe::TokenizedNlpPipe`: The input `TokenizedNlpPipe` object containing the tokens to be processed.
- `language::String = "en"`: Defaults to english, other languages are possible

# Returns
- `TokenizedNlpPipe`: A new `TokenizedNlpPipe` object with the stemmed tokens.

# Example Usage

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


