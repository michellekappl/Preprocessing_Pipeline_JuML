using Preprocessing_Pipeline_JuML
using Test

@testset verbose=true "Testing:" begin
    include("pipes/NlpPipeTests.jl")
    include("pipes/TokenizedNlpPipeTests.jl")

    include("preprocessing/afterTokenization/removeStopWordsTests.jl")
    include("preprocessing/beforeTokenization/expandContractionsTests.jl")
    include("preprocessing/beforeTokenization/maskNumbersTests.jl")
    include("preprocessing/beforeTokenization/removeNoiseTests.jl")
    include("preprocessing/beforeTokenization/standardizeTextTests.jl")
end