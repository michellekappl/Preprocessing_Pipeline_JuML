struct VectorizedNlpPipe
   tokens::Vector{Vector{Vector{Int}}}
   vocabulary::Dict{String, Int}
end

export VectorizedNlpPipe