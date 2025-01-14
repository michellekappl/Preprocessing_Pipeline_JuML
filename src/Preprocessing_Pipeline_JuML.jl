module Preprocessing_Pipeline_JuML

include("pipes/NlpPipe.jl")
include("pipes/TokenizedNlpPipe.jl")
include("pipes/VectorizedNlpPipe.jl")

include("tokenization/tokenizer.jl")

include("preprocessing/removeNoise.jl")

include("vectorization/oneHotEncoding.jl")
include("vectorization/bagOfWords.jl")

export NlpPipe, TokenizedNlpPipe, VectorizedNlpPipe, tokenize, remove_noise, one_hot_encoding

end