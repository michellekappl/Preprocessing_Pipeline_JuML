module Preprocessing_Pipeline_JuML

include("pipes/NlpPipe.jl")
include("pipes/TokenizedNlpPipe.jl")
include("pipes/VectorizedNlpPipe.jl")

include("tokenization/tokenizeLevel.jl")
include("tokenization/tokenizer.jl")

include("preprocessing/removeNoise.jl")

include("vectorization/oneHotEncoding.jl")
end