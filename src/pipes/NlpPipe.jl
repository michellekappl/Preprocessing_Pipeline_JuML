struct NlpPipe
   corpus::Vector{String}
   labels::Union{Vector{String}, Nothing}

   function NlpPipe(corpus::Vector{String}, labels::Vector{String})
      if length(corpus) != length(labels)
         throw(ArgumentError("The number of documents and labels must be the same."))
      end

      new(corpus, labels)
   end

   NlpPipe(corpus::String) = new([corpus], Nothing)  # Allow initializing with a single string
end

export NlpPipe