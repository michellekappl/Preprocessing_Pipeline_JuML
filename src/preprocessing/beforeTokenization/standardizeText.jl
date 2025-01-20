using StringEncodings

function standardize_document(doc::String)::String
   doc = lowercase(doc)
   doc = replace(doc, 
      "’" => "'",
      "“" => "\"",
      "”" => "\"",
      "–" => "-",
      "—" => "-",
      "…" => "...",
      "​" => "" # Zero-width space
   )
end

"""
   standardize_text(input::NlpPipe)
   
Standardizes the text by converting it to lowercase and replacing unusual characters with their standard counterparts.
"""
function standardize_text(pipe::NlpPipe)::NlpPipe
   corpus = map(standardize_document, pipe.corpus)
   return NlpPipe(corpus, pipe.labels)
end