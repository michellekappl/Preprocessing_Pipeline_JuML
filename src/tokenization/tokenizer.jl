function tokenize_document(doc::String, level::Symbol = :word)::Vector{String}
    if level === :word
        return map(string, split(doc))  # Split returns Vector{Substring}, so convert to String
    elseif level === :character
        return map(string, collect(doc))  # Collect returns Vector{Char}, so convert to String as well
    else 
        throw(ArgumentError("Invalid tokenization level: $level"))
    end
end

"""
    tokenize(pipe::NlpPipe, level::Symbol = :word) -> TokenizedNlpPipe

Tokenizes the documents in the corpus of the given `NlpPipe` object. The `level` parameter sets depth of tokenizing.
# Arguments
- `pipe::NlpPipe`: An `NlpPipe` object containing a corpus of documents.
- `level::Symbol`: The tokenization level, either `:word` (default) or `:character`.

# Returns
- `TokenizedNlpPipe`: A new pipe object with the tokenized documents.

# Example Usage
```jldoctest repl
julia> NlpPipe(["Hello world", "Julia is great"]) |> tokenize
TokenizedNlpPipe(["Hello world", "Julia is great"], [["Hello", "world"], ["Julia", "is", "great"]], Set(["great", "Hello", "is", "Julia", "world"]), nothing)
```
---
"""
function tokenize(pipe::NlpPipe, level::Symbol = :word)::TokenizedNlpPipe
    tokenized_corpus = map(document -> tokenize_document(document, level), pipe.corpus)
    return TokenizedNlpPipe(pipe.corpus, tokenized_corpus, pipe.labels)
end

export tokenize