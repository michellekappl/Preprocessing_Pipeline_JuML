using SnowballStemmer

"""
    stemming(pipe::TokenizedNlpPipe; language::String="english") -> TokenizedNlpPipe
 
    Reduces words to their roots by removing pre- and suffixes. These are provided by [SnowballStemmer.jl](https://docs.juliahub.com/General/SnowballStemmer/stable/).

 # Arguments
- `pipe::TokenizedNlpPipe`: The input `TokenizedNlpPipe` object containing the tokens to be processed.
- `language::String = "en"`: Defaults to english, other languages are possible

# Returns
- `TokenizedNlpPipe`: A new `TokenizedNlpPipe` object with the stemmed tokens.

# Example Usage
## Applying stemming with the default language (English)
```jldoctest repl
julia> NlpPipe(["This is a test for stemming"]) |> tokenize |> stemming
TokenizedNlpPipe(["This is a test for stemming"], [["This", "is", "a", "test", "for", "stem"]], Set(["test", "is", "This", "stem", "a", "for"]), nothing)
```
---

"""
function stemming(pipe::TokenizedNlpPipe; language::String="english")::TokenizedNlpPipe
    #create stemmer specified language
    stemmer = Stemmer(language)
    
    #do stemming to each word from input
    stemmed_data = Vector{Vector{String}}()
    for doc in pipe.tokens
        stemmed_doc = [stem(stemmer, word) for word in doc]
        push!(stemmed_data, stemmed_doc)
    end
    
    return TokenizedNlpPipe(pipe.corpus, stemmed_data, pipe.labels)

end


