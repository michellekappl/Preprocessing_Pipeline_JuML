function cleaning_text(input) #allowed inputs: List of strings and strings
    if typeof(input)==String #doing direct noise cleaning
        cleaned_text=replace(lowercase(input), r"[^a-z\s]" => "") #removing non alphabetical elements
    elseif typeof(input)==Vector{String} #noise cleaning for each element in list
        cleaned_text=[]
        for i in (1: length(input))
            push!(cleaned_text,cleaning_text(input[i]))
        end
    end
    return cleaned_text
end