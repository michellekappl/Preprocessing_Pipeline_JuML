"""
stemming(input) stems words to their origin, default language is english, we're using SnowballStemmer.jl
"""


function stemming(input::Vector{String}; language::String="english")
    @eval using SnowballStemmer
    #create stemmer specified language
    stemmer = Stemmer(language)
    
    #do stemming to each word from input
    stemmed_words = [stem(stemmer, word) for word in input]
    
    return stemmed_words
end

export stemming
