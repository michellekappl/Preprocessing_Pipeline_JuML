"""
    TokenizedNlpPipe

A structure for handling tokenized text data, maintaining a vocabulary and optional labels.

# Fields
- `corpus::Vector{String}`: A collection of original text documents.
- `tokens::Vector{Vector{String}}`: Tokenized representation of each document in `corpus`.
- `vocabulary::Set{String}`: A set of unique tokens derived from `tokens`.
- `labels::Union{Vector{String}, Nothing}`: Optional labels corresponding to each document.

# Constructors
- `TokenizedNlpPipe(corpus::Vector{String}, tokens::Vector{Vector{String}}, labels::Union{Vector{String}, Nothing})`  
   Creates a `TokenizedNlpPipe` instance with a given corpus, tokenized documents, and optional labels.  
   The vocabulary is automatically generated from `tokens`.

- `TokenizedNlpPipe(previousPipe::TokenizedNlpPipe; tokens::Vector{Vector{String}} = previousPipe.tokens, vocabulary::Set{String} = previousPipe.vocabulary, labels::Union{Vector{String}, Nothing} = previousPipe.labels)`  
   Creates a new `TokenizedNlpPipe` instance based on an existing one, allowing modifications to tokens, vocabulary, and labels while retaining the original corpus.

# Example Usage
---
## Creating a pipe from an NlpPipe instance (usual way to do it)
```julia
julia> corpus = ["Hello world", "Julia is great"]
2-element Vector{String}:
 "Hello world"
 "Julia is great"
julia> tokenizedPipe = NlpPipe(corpus) |> tokenize
TokenizedNlpPipe(["Hello world", "Julia is great"], [["Hello", "world"], ["Julia", "is", "great"]], Set(["great", "Hello", "is", "Julia", "world"]), nothing)
```
---
## Creating a new pipe from scratch
```julia
julia> corpus = ["Hello world", "Julia is great"]
2-element Vector{String}:
 "Hello world"
 "Julia is great"

julia> tokens = [["Hello", "world"], ["Julia", "is", "great"]]
2-element Vector{Vector{String}}:
 ["Hello", "world"]
 ["Julia", "is", "great"]
 
julia> TokenizedNlpPipe(corpus, tokens, ["greeting", "statement"])
TokenizedNlpPipe(["Hello world", "Julia is great"], [["Hello", "world"], ["Julia", "is", "great"]], Set(["great", "Hello", "is", "Julia", "world"]), ["greeting", "statement"])
````
---
## Creating a new pipe from an existing one with modified tokens
```julia
julia> pipe1 = TokenizedNlpPipe(corpus, tokens, ["greeting", "statement"])
TokenizedNlpPipe(["Hello world", "Julia is great"], [["Hello", "world"], ["Julia", "is", "great"]], Set(["great", "Hello", "is", "Julia", "world"]), ["greeting", "statement"])

julia> pipe2 = TokenizedNlpPipe(pipe1; tokens=[["Hello"], ["Julia", "is"]])
TokenizedNlpPipe(["Hello world", "Julia is great"], [["Hello"], ["Julia", "is"]], Set(["great", "Hello", "is", "Julia", "world"]), ["greeting", "statement"])
```
---
"""
struct TokenizedNlpPipe
   corpus::Vector{String}
   tokens::Vector{Vector{String}}
   vocabulary::Set{String}
   labels::Union{Vector{String}, Nothing}

   # Constructor for the first pipe in the pipeline
   function TokenizedNlpPipe(corpus::Vector{String}, tokens::Vector{Vector{String}}, labels::Union{Vector{String}, Nothing})
      vocabulary = Set{String}(reduce(vcat, tokens))
      new(corpus, tokens, vocabulary, labels)
   end

   # Constructor for subsequent pipes in the pipeline (tokens and vocab are copied by default)
   function TokenizedNlpPipe(previousPipe::TokenizedNlpPipe; tokens::Vector{Vector{String}} = previousPipe.tokens, vocabulary::Set{String} = previousPipe.vocabulary, labels::Union{Vector{String}, Nothing} = previousPipe.labels)
      new(previousPipe.corpus, tokens, vocabulary, labels)
   end
end

export TokenizedNlpPipe