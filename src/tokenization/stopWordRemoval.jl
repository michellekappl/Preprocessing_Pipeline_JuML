"""
stop_word_removal(input)

removes predefined stopwords, default is english, others can be choosen easily
"""
#
#hab leider keine ahnung merh wie man das mit den packages die man nutzt macht -.-, https://github.com/guo-yong-zhi/StopWords.jl/blob/main/README.md
function stop_word_removal(input::Vector{String}, language="English")
    @eval using StopWords
    stopwords_set=stopwords[language]
    for i in (length(input):-1:1)
        if input[i] in stopwords_set
            deleteat!(input,i)

        end

    end
    return input

end
export stop_word_removal