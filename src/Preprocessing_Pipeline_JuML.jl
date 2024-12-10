module Preprocessing_Pipeline_JuML

include("cleaning_text.jl")
include("change_numbers.jl")
include("tokenizer.jl")

timesx(x, y) = y*x

export timesx

end
