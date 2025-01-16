"""
    number_to_word(input)

    Allows user to preprocess numbers within a string. Each number, independent of length gets replaced with word: *number*, 
    inputs: Strings and Vector{String}
    output: Strings and Vector{String} respectively
"""
function mask_numbers(pipe::NlpPipe; replace_with::String="[NUM]")::NlpPipe
    corpus = map(document -> replace(document, r"\d+(?:\.\d+)?\b" => replace_with), pipe.corpus)
    return NlpPipe(corpus, pipe.labels)
end