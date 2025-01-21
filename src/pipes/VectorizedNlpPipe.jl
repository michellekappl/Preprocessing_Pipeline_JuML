struct VectorizedNlpPipe
   tokens::Vector{Matrix{<:Union{Int, Float64}}} 
   vocabulary::Dict{String, Int}
   labels::Union{Vector{String}, Nothing}
end

export VectorizedNlpPipe
