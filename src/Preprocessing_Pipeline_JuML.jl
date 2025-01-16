module Preprocessing_Pipeline_JuML

include("pipes/NlpPipe.jl")
include("pipes/TokenizedNlpPipe.jl")
include("pipes/VectorizedNlpPipe.jl")

include("tokenization/tokenizeLevel.jl")
include("tokenization/tokenizer.jl")

include("preprocessing/removeNoise.jl")

include("vectorization/oneHotEncoding.jl")
include("vectorization/bagOfWords.jl")
include("vectorization/bagOfNGrams.jl")

export NlpPipe, TokenizedNlpPipe, VectorizedNlpPipe, tokenizeLevel, tokenize, remove_noise, one_hot_encoding, bag_of_words, bag_of_ngrams

end