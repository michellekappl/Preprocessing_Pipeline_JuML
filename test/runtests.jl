using Preprocessing_Pipeline_JuML
using Test

@testset verbose=true "Testing:" begin
    include("pipes/NlpPipeTests.jl")
    include("pipes/TokenizedNlpPipeTests.jl")
    include("pipes/VectorizedNlpPipeTests.jl")

    include("preprocessing/afterTokenization/removeStopWordsTests.jl")
    include("preprocessing/afterTokenization/standardizeEncodingTests.jl")
    include("preprocessing/beforeTokenization/expandContractionsTests.jl")
    include("preprocessing/beforeTokenization/maskNumbersTests.jl")
    include("preprocessing/beforeTokenization/removeNoiseTests.jl")
    include("preprocessing/beforeTokenization/standardizeTextTests.jl")
    include("preprocessing/afterTokenization/stemmingTests.jl")


    include("vectorization/oneHotEncodingTests.jl")
    include("vectorization/bagOfWordsTests.jl")
    include("vectorization/bagOfNGramsTests.jl")
    include("vectorization/tfIdfTests.jl")
end