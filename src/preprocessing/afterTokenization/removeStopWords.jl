using StopWords: stopwords

"""
    remove_stop_words(pipe::TokenizedNlpPipe; language::String="en", stop_words::Set{String}=Set{String}()) -> TokenizedNlpPipe

Removes predefined stopwords. You can access the stop words for a given language using the language name or ISO 639 code. 
For example, to get the stop words for English, you can use stopwords["eng"], stopwords["en"], or stopwords["English"].

Stop words sourced from [StopWords.jl](https://github.com/guo-yong-zhi/StopWords.jl/blob/main/README.md).

# Arguments
- `pipe::TokenizedNlpPipe`: The input `TokenizedNlpPipe` object containing the tokens to be processed.
- `language::String = "en"`: Defaults to english, other languages are possible (see linked github-page above)
- `stop_words::Set{String} = Set{String}()`: Defaults to `StopWords.jl`-stopwords set, possible to set own stopword-set.

# Returns
- `TokenizedNlpPipe`: A new pipe object with the stop words removed from the tokens.


# Example Usage
## Removing stop words from a tokenized pipe (default stop words)
```jldoctest repl
julia> NlpPipe(["This is a dinosaur"]) |> tokenize |> remove_stop_words |> pipe -> pipe.tokens
1-element Vector{Vector{String}}:
 ["This", "dinosaur"]
```
---
## Using custom stop words
```jldoctest repl
julia> NlpPipe(["This is a dinosaur"]) |> tokenize |> pipe -> remove_stop_words(pipe, stop_words=Set(["This", "dinosaur"])) |> pipe -> pipe.tokens
1-element Vector{Vector{String}}:
 ["is", "a"]
```
"""
function remove_stop_words(pipe::TokenizedNlpPipe; language::String="en", stop_words::Set{String}=Set{String}())::TokenizedNlpPipe
    stopwords_set = length(stop_words) > 0 ? stop_words : stopwords[language]

    tokens = map(filter(!in(stopwords_set)), pipe.tokens)
    return TokenizedNlpPipe(pipe.corpus, tokens, pipe.labels)
end