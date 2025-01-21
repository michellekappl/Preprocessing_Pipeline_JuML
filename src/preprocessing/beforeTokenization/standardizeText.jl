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
   standardize_document(doc::String)::String

Standardizes a document by converting it to lowercase and replacing unusual characters with their standard counterparts.

# Arguments
- `doc::String`: The input document as a string.

# Returns
- `String`: The standardized document as a string.
"""
function standardize_text(pipe::NlpPipe)::NlpPipe
   corpus = map(standardize_document, pipe.corpus)
   return NlpPipe(corpus, pipe.labels)
end