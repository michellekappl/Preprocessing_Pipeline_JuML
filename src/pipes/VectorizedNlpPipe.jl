struct VectorizedNlpPipe
   tokens::Vector{Vector{Vector{Int}}}
   vocabulary::Dict{String, Int}
   labels::Union{Vector{String}, Nothing}
end

export VectorizedNlpPipe