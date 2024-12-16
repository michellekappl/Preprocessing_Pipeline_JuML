#splits input text on space, input can be String or Vector{String}
function tokenizer(input) 
    if typeof(input)==String 
        tokens=split(lowercase(input)," ")      #splitting on space
    elseif typeof(input)==Vector{String}        #splitting for each element in list
        tokens=[]
        for i in (1:length(input))
            push!(tokens,tokenizer(input[i]))
        end       
    end
    return tokens
end
#output is Vector{Substring{String}}
export tokenizer
