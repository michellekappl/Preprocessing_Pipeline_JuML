struct TokenizedNlpPipe
   corpus::Vector{String}
   tokens::Vector{Vector{String}}
   vocabulary::Set{String}

   # Constructor for the first pipe in the pipeline
   function TokenizedNlpPipe(corpus::Vector{String}, tokens::Vector{Vector{String}})
      vocabulary = Set{String}(reduce(vcat, tokens))
      new(corpus, tokens, vocabulary)
   end

   # Constructor for subsequent pipes in the pipeline (tokens and vocab are copied by default)
   function TokenizedNlpPipe(previousPipe::TokenizedNlpPipe; tokens::Vector{Vector{String}} = previousPipe.tokens, vocabulary::Set{String} = previousPipe.vocabulary)
      new(previousPipe.corpus, tokens, vocabulary)
   end
end

export TokenizedNlpPipe