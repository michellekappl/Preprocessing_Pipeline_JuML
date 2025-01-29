"""
    NlpPipe

A simple pipeline structure for handling text data (corpus) and corresponding labels.

# Fields
- `corpus::Vector{String}`: A collection of text documents.
- `labels::Union{Vector{String}, Nothing}`: Optional labels corresponding to each document in `corpus`.

# Constructors
- `NlpPipe(corpus::Vector{String}, labels::Union{Vector{String}, Nothing})`  
   Creates an `NlpPipe` instance with a given corpus and optional labels.  
   **Throws** an `ArgumentError` if the number of documents and labels do not match.

- `NlpPipe(corpus::Vector{String})`  
   Creates an `NlpPipe` instance with only a corpus, setting `labels` to `nothing`.

- `NlpPipe(corpus::String)`  
   Creates an `NlpPipe` instance with a single document, storing it in a vector.

- `NlpPipe(previousPipe::NlpPipe; corpus::Vector{String} = previousPipe.corpus, labels::Union{Vector{String}, Nothing} = previousPipe.labels)`  
   Creates a new `NlpPipe` instance based on an existing one, optionally overriding `corpus` and `labels`.  
   **Throws** an `ArgumentError` if `labels` is not `nothing` and its length does not match the corpus length.

# Example Usage
---
## Creating a pipe from a corpus with multiple documents, including labels
```jldoctest repl
julia> pipe1 = NlpPipe(["document1", "document2"], ["label1", "label2"])
NlpPipe(["document1", "document2"], ["label1", "label2"])
```
---
## Creating a pipe from a corpus without labels
```jldoctest repl
julia> pipe2 = NlpPipe(["document3"])
NlpPipe(["document3"], nothing)
```
---
## Creating a pipe from a single string corpus
```jldoctest repl
julia> pipe3 = NlpPipe("single document") 
NlpPipe(["single document"], nothing)
```
---
## Creating a new pipe from an existing one with modified corpus and labels
```jldoctest repl
julia> NlpPipe(pipe1, corpus=["new_doc1", "new_doc2"])
NlpPipe(["new_doc1", "new_doc2"], ["label1", "label2"])
```
"""
struct NlpPipe
   corpus::Vector{String}
   labels::Union{Vector{String}, Nothing}

   function NlpPipe(corpus::Vector{String}, labels::Union{Vector{String}, Nothing})
      if !isnothing(labels) && length(corpus) != length(labels)
         throw(ArgumentError("The number of documents and labels must be the same."))
      end

      new(corpus, labels)
   end

   NlpPipe(corpus::Vector{String}) = new(corpus, nothing)

   NlpPipe(corpus::String) = new([corpus], nothing)  # Allow initializing with a single string

   function NlpPipe(previousPipe::NlpPipe; corpus::Vector{String} = previousPipe.corpus, labels::Union{Vector{String}, Nothing} = previousPipe.labels)
      # no need to check if corpus and labels match, as it's already done in the initial constructor
      new(corpus, labels)
   end
end

export NlpPipe