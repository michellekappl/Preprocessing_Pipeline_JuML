"""
    number_to_word(input)

    Allows user to preprocess numbers within a string. Each number, independent of length gets replaced with word: *number*, 
    inputs: Strings and Vector{String}
    output: Strings and Vector{String} respectively
"""

function number_to_word(input)
    if typeof(input)==String
       nums_to_word = replace(input, r"\d+" => "number") 
        
    elseif typeof(input)==Vector{String}    
        nums_to_word=[]
        for i in input
            push!(nums_to_word,number_to_word(i))
        end 
    end
    return nums_to_word

end
export number_to_word