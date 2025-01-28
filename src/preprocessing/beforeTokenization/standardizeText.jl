using StringEncodings
"""

    standardize_document(doc::String)::String

Standardizes a document by converting it to lowercase and replacing unusual characters with their standard counterparts.

# Parameters
- `doc::String`: The input document as a string.

# Returns
- `String`: The standardized document as a string.
"""
function standardize_document(doc::String)::String
   doc = lowercase(doc)
   doc = replace(doc, 
      "’" => "'",
      "“" => "\"",
      "”" => "\"",
      "–" => "-",
      "—" => "-",
      "…" => "...",
      "​" => "" # Zero-width space
   )
end


"""
    standardize_text(pipe::NlpPipe) -> NlpPipe

Applies the `standardize_document` function to each document in the corpus of the given `NlpPipe` object.

# Parameters
- `pipe::NlpPipe`: An `NlpPipe` object containing a corpus and associated labels.

# Returns
- A new `NlpPipe` object with the standardized corpus and the original labels.

# Example Usage
```jldoctest repl
julia> NlpPipe(["Hello WORLD", "Julia is GREAT"]) |> standardize_text
NlpPipe(["hello world", "julia is great"], nothing)
```
---
"""
function standardize_text(pipe::NlpPipe)::NlpPipe
   corpus = map(standardize_document, pipe.corpus)
   return NlpPipe(corpus, pipe.labels)
end