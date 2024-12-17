struct NlpPipe
   corpus::Vector{String}

   NlpPipe(corpus::Vector{String}) = new(corpus)
   NlpPipe(corpus::String) = new([corpus])  # Allow initializing with a single string
end

export NlpPipe