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