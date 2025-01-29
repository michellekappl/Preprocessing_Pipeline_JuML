"""
    mask_numbers(pipe::NlpPipe; replace_with::String="<NUM>") -> NlpPipe

Replaces all numbers in the text of the given `NlpPipe` corpus with a specified string.

# Arguments
- `pipe::NlpPipe`: The input `NlpPipe` object containing the corpus to be processed.
- `replace_with::String`: The string to replace numbers with. Defaults to "<NUM>".

# Returns
- `NlpPipe`: A pipe object with the numbers in the corpus replaced by the specified string.

# Example Usage
```jldoctest repl
julia> NlpPipe(["The price is 1000€."]) |> mask_numbers
NlpPipe(["The price is <NUM>€."], nothing)
```
"""
function mask_numbers(pipe::NlpPipe; replace_with::String="<NUM>")::NlpPipe
    corpus = map(document -> replace(document, r"\d+(?:\.\d+)?\b" => replace_with), pipe.corpus)
    return NlpPipe(corpus, pipe.labels)
end