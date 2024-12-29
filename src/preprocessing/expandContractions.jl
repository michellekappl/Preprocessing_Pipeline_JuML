"""
    Allows user to expand contractions like 'I've', 'can't' and so on. This program cannot differentiate between 'he has' and 'he is' as expansion for 'he's' (and same for she'd: she would/she had)
    The default is expanding any 's contraction to 'is', and 'd to 'had'. The contraction 'won't' is not yet correctly covered (turns into 'wo not').
    inputs: Strings and Vector{String}
    output: Strings and Vector{String} respectively
"""


function expand_contractions(input)
    contractions_dict = Dict(
        "'s"=> " is", "n't"=>" not", "'ll"=> " will", "'ve"=> " have", "'d"=> " had", "'m" => " am", "'re" => " are" 
    )
    if typeof(input)==String

        expanded = replace(input, r"(?:n't|'(?:ll|re|ve|d|s|m|t))" => suffix -> contractions_dict[suffix])

    elseif typeof(input)==Vector{String}       
        expanded=[]
        for i in input
            push!(expanded,expand_contractions(i))
        end 
    end
    return expanded
end
export expand_contractions