module Preprocessing_Pipeline_JuML

include("pipes/NlpPipe.jl")
include("pipes/TokenizedNlpPipe.jl")
include("pipes/VectorizedNlpPipe.jl")

include("tokenization/tokenizeLevel.jl")
include("tokenization/tokenizer.jl")

include("preprocessing/removeNoise.jl")

include("vectorization/oneHotEncoding.jl")

test_corpus = [
   "Hello <b>world</b>! Visit http://example.com.",
   "Email me: test@example.com or call +123-456-7890.",
   "Today is 12/25/2024, time now: 10:30AM.",
   "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.",
   "Check this out: www.awesome-website.org/about-us.html!",
   "#JuliaLang is great. Follow us @JuliaNLP."
]

pipe = NlpPipe(test_corpus) |> remove_noise |> tokenize |> one_hot_encoding

end