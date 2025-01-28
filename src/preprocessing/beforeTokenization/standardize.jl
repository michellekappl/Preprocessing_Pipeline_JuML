function standardization(corpus::Vector{Vector{String}}; 
    lowercasing::Bool = true, 
    encoding::String = "ASCII")::Vector{Vector{String}}
"""
Preprocess a tokenized text corpus with options for ASCII/UTF-8 encoding and lowercasing.

Arguments:
corpus::Vector{Vector{String}}: A tokenized text corpus where each document is a vector of tokens.

Keyword Arguments:
lowercasing::Bool: If true, convert tokens to lowercase (default is true).
encoding::String: The target encoding, either "ASCII" or "UTF-8" (default is "ASCII").

Returns:
Vector{Vector{String}}: The processed corpus with selected transformations applied.
"""
function process_token(token::String)::String
# Replace invalid tokens with <UNK>
if encoding == "ASCII" && !isascii(token)
return "<UNK>"
elseif encoding == "UTF-8" && !isvalid(token)
return "<UNK>"
end

# Apply lowercasing if enabled
return lowercasing ? lowercase(token) : token
end

# Apply the processing function to each token
return [map(process_token, document) for document in corpus]
end

export standardization
#####TEST########
#corpus = [["héllo", "WORLD"], ["thís", "is", "a", "tëst"], ["ASCII", "only", "!"]] 
#corpus = [["héllo", "WORLD"], ["thís", "is", "a", "tëst"], ["ASCII", "only", "\xC3"]] -> for UTF-8 test the last string "\xC3" should be replaced with <UNK>
