using SnowballStemmer

"""
    stemming(pipe::TokenizedNlpPipe; language::String="english") -> TokenizedNlpPipe

Applies stemming to the tokens in the provided `TokenizedNlpPipe` based on the specified language.

Stemming reduces words to their base or root form (e.g., "running" to "run"). This function uses the Snowball stemmer library, which supports multiple languages.

# Parameters
- `pipe::TokenizedNlpPipe``: The input pipeline containing tokenized data.
- `language::String = "english"`: The language to use for stemming. Supported languages depend on the Snowball stemmer library.

# Returns
- A new `TokenizedNlpPipe` struct with the tokens replaced by their stemmed versions.

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

export stemming
