module Preprocessing_Pipeline_JuML

include("pipes/NlpPipe.jl")
include("pipes/TokenizedNlpPipe.jl")
include("pipes/VectorizedNlpPipe.jl")

include("tokenization/tokenizer.jl")

include("preprocessing/beforeTokenization/removeNoise.jl")
include("preprocessing/beforeTokenization/maskNumbers.jl")
include("preprocessing/beforeTokenization/expandContractions.jl")
include("preprocessing/beforeTokenization/standardizeText.jl")

include("preprocessing/afterTokenization/standardizeEncoding.jl")
include("preprocessing/afterTokenization/removeStopWords.jl")

include("vectorization/oneHotEncoding.jl")
include("vectorization/bagOfWords.jl")
include("vectorization/bagOfNGrams.jl")
include("vectorization/tfIdf.jl")

export 
    # Pipe Structs
    NlpPipe, 
    TokenizedNlpPipe, 
    VectorizedNlpPipe, 

    # Tokenization
    tokenize, 

    # Preprocessing
    expand_contractions,
    mask_numbers,
    one_hot_encoding,
    remove_noise,  
    remove_stop_words, 
    standardize_text,
    standardize_encoding,

    # Vectorization
    bag_of_ngrams,
    bag_of_words,
    one_hot_encoding,
    tf_idf
end