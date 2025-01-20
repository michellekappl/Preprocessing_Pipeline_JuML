struct NlpPipe
   corpus::Vector{String}
   labels::Union{Vector{String}, Nothing}

   function NlpPipe(corpus::Vector{String}, labels::Union{Vector{String}, Nothing})
      if labels !== nothing && length(corpus) != length(labels)
         throw(ArgumentError("The number of documents and labels must be the same."))
      end

      new(corpus, labels)
   end

   NlpPipe(corpus::Vector{String}) = new(corpus, nothing)

   NlpPipe(corpus::String) = new([corpus], nothing)  # Allow initializing with a single string

   function NlpPipe(previousPipe::NlpPipe; corpus::Vector{String} = previousPipe.corpus, labels::Union{Vector{String}, Nothing} = previousPipe.labels)
      if labels !== nothing && length(corpus) != length(labels)
         throw(ArgumentError("The number of documents and labels must be the same."))
      end

      new(corpus, labels)
   end
end

export NlpPipe