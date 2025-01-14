module Preprocessing_Pipeline_JuML

include("pipes/NlpPipe.jl")
include("pipes/TokenizedNlpPipe.jl")
include("pipes/VectorizedNlpPipe.jl")

include("tokenization/tokenizer.jl")

include("preprocessing/beforeTokenization/removeNoise.jl")
include("preprocessing/beforeTokenization/maskNumbers.jl")
include("preprocessing/beforeTokenization/expandContractions.jl")
include("preprocessing/beforeTokenization/standardizeText.jl")

include("preprocessing/afterTokenization/removeStopWords.jl")

include("vectorization/oneHotEncoding.jl")

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
   standardize_text

   # Vectorization
end