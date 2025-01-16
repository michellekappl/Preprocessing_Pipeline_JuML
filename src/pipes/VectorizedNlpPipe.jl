struct VectorizedNlpPipe
      tokens::Vector{Matrix{Int}} 
   vocabulary::Dict{String, Int}
end

export VectorizedNlpPipe