module Preprocessing_Pipeline_JuML

include("playground.jl")

timesx(x, y) = y*x

include("cleaning_text.jl")
include("one_hot_encoding.jl")

export timesx, one_got_encoding, cleaning_text

end
