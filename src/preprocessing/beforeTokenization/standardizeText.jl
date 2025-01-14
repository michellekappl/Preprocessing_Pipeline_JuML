using StringEncodings

unusual_characters = Dict(
   '’' => "'",
   '“' => "\"",
   '”' => "\"",
   '–' => "-",
   '—' => "-",
   '…' => "...",
   '​' => "",  # Zero-width space
)

function standardize_document(doc::String)::String
   doc = lowercase(doc)
   doc = replace(doc, unusual_characters)
end

"""
   standardize_text(input::NlpPipe)

Standardizes the text by converting it to lowercase and replacing unusual characters with their standard counterparts.
"""
function standardize_text(input::NlpPipe)::NlpPipe
   corpus = map(standardize_document, input.corpus)
   return NlpPipe(corpus)
end