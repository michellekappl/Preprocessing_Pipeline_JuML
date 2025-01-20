struct VectorizedNlpPipe
   tokens::Vector{Matrix{Int}} 
   vocabulary::Dict{String, Int}
   labels::Union{Vector{String}, Nothing}
end

export VectorizedNlpPipe