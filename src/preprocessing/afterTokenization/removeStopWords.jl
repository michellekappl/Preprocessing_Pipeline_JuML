using StopWords

"""
    remove_stop_words(pipe::TokenizedNlpPipe; language::String="en", stop_words::Set{String}=Set{String}())

Removes predefined stopwords. You can access the stop words for a given language using the language name or ISO 639 code. 
For example, to get the stop words for English, you can use stopwords["eng"], stopwords["en"], or stopwords["English"].

Stop words sourced from https://github.com/guo-yong-zhi/StopWords.jl/blob/main/README.md.

# Parameters
- pipe: TokenizedNlpPipe
- language: String = "en"
- stop_words: Set{String} = Set{String}()

# Returns
- A new `TokenizedNlpPipe`struct with the stop words removed from the tokens.

# Examples
```julia
NlpPipe(["This is a test"]) |> tokenize |> remove_stop_words |> pipe -> pipe.tokens # [["This", "test"]]
NlpPipe(["This is a test"]) |> tokenize |> remove_stop_words(stop_words=["test"]) |> pipe -> pipe.tokens # [["This", "is", "a"]]
```
"""
function remove_stop_words(pipe::TokenizedNlpPipe; language::String="en", stop_words::Set{String}=Set{String}())::TokenizedNlpPipe
    stopwords_set = length(stop_words) > 0 ? stop_words : stopwords[language]

    tokens = map(document -> filter(token -> !(token in stopwords_set), document), pipe.tokens)
    return TokenizedNlpPipe(pipe.corpus, tokens, pipe.labels)
end