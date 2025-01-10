"""
    expand_numbers(input)
    changing numbers in numerical format to string representation in english,
    input: Strings and Vector{String}
"""

function expand_numbers(input)
    digit_to_word = Dict(
        "0" => "zero", "1" => "one", "2" => "two", "3" => "three", 
        "4" => "four", "5" => "five", "6" => "six", "7" => "seven", 
        "8" => "eight", "9" => "nine"
    )
    if typeof(input)==String
        str_wo_num= replace(input, r"[0-9]"=>digit->digit_to_word[digit]) 
        
    elseif typeof(input)==Vector{String}        #replacing for each element in list
        str_wo_num=[]
        for i in input
            push!(str_wo_num,expand_numbers(i))
        end 
    end
    return str_wo_num
end

export expand_numbers