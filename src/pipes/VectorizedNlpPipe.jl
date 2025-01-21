"""
    VectorizedNlpPipe

A structure for handling vectorized representations of tokenized text data, including a vocabulary mapping and optional labels.

# Fields
- `tokens::Vector{Matrix{<:Union{Int, Float64}}}`: A collection of numerical representations (e.g., embeddings, one-hot encodings) for tokenized text.
- `vocabulary::Dict{String, Int}`: A dictionary mapping words to unique integer indices.
- `labels::Union{Vector{String}, Nothing}`: Optional labels corresponding to each document.

# Example Usage
---
## Creating a pipe from an existing TokenizedNlpPipe instance (usual way to do it)
```jldoctest repl
julia> corpus = ["Hello world", "Julia is great"]
2-element Vector{String}:
 "Hello world"
 "Julia is great"

julia> NlpPipe(corpus) |> tokenize |> one_hot_encoding # (or any other vectorization method)
VectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[0 1 … 0 0; 0 0 … 0 1], [0 0 … 1 0; 0 0 … 0 0; 1 0 … 0 0]], Dict("great" => 1, "Hello" => 2, "is" => 3, "Julia" => 4, "world" => 5), nothing)
```
---
## Creating a pipe from scratch
```jldoctest repl
julia> tokens = [[1 2; 3 4], [5 6; 7 8]]  # Example word embeddings (each document is a matrix)
2-element Vector{Matrix{Int64}}:
 [1 2; 3 4]
 [5 6; 7 8]

julia> vocab = Dict("hello" => 1, "world" => 2, "Julia" => 3)
Dict{String, Int64} with 3 entries:
  "hello" => 1
  "Julia" => 3
  "world" => 2

julia> labels = ["greeting", "statement"]
2-element Vector{String}:
 "greeting"
 "statement"

julia> VectorizedNlpPipe(tokens, vocab, labels)
VectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[1 2; 3 4], [5 6; 7 8]], Dict("hello" => 1, "Julia" => 3, "world" => 2), ["greeting", "statement"])
```
---
"""
struct VectorizedNlpPipe
   tokens::Vector{Matrix{<:Union{Int, Float64}}} 
   vocabulary::Dict{String, Int}
   labels::Union{Vector{String}, Nothing}
end

export VectorizedNlpPipe
