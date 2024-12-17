struct TokenizedNlpPipe
   corpus::Vector{String}
   tokens::Vector{Vector{String}}
   vocabulary::Set{String}

   function TokenizedNlpPipe(corpus::Vector{String}, tokens::Vector{Vector{String}})
      vocabulary = Set{String}(reduce(vcat, tokens))
      new(corpus, tokens, vocabulary)
   end

   function TokenizedNlpPipe(previousPipe::TokenizedNlpPipe; tokens::Vector{Vector{String}} = previousPipe.tokens, vocabulary::Set{String} = previousPipe.vocabulary)
      new(previousPipe.corpus, tokens, vocabulary)
   end
end

export TokenizedNlpPipe