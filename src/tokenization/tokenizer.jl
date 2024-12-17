function tokenize_document(doc::String, level::TokenizeLevel = word)::Vector{String}
    if level == word
        return map(string, split(doc))  # Split returns Vector{Substring}, so convert to String
    elseif level == character
        return map(string, collect(doc))  # Collect returns Vector{Char}, so convert to String as well
    end
end

function tokenize(pipe::NlpPipe, level::TokenizeLevel = word)::TokenizedNlpPipe
    tokenized_corpus = map(document -> tokenize_document(document, level), pipe.corpus)
    return TokenizedNlpPipe(pipe.corpus, tokenized_corpus)
end

export tokenize