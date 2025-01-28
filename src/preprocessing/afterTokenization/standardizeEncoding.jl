
"""
    standardize_encoding(pipe::TokenizedNLPPipe, encoding::String = "ASCII") -> TokenizedNLPPipe

Standardizes the encoding of the tokens in the corpus.

# Parameters
- `pipe::TokenizedNlpPipe`: A `TokenizedNlpPipe` object containing a corpus and associated labels.
- `encoding::String`: The target encoding, either "ASCII" or "UTF-8" (default is "ASCII").

# Returns
- A new `TokenizedNlpPipe` object with the standardized corpus and the original labels.

# Example Usage
## Using the default encoding
```jldoctest repl
julia> NlpPipe(["Hello world 😊", "Julia is great"]) |> tokenize |> standardize_encoding
TokenizedNlpPipe(["Hello world 😊", "Julia is great"], [["Hello", "world", "<UNK>"], ["Julia", "is", "great"]], Set(["great", "Hello", "is", "Julia", "<UNK>", "world"]), nothing)
```
## Using the UTF-8 encoding
```jldoctest repl
julia> NlpPipe(["Hello world 😊", "Julia is great"]) |> tokenize |> pipe -> standardize_encoding(pipe, encoding="UTF-8")
TokenizedNlpPipe(["Hello world 😊", "Julia is great"], [["Hello", "world", "😊"], ["Julia", "is", "great"]], Set(["great", "Hello", "is", "Julia", "world", "😊"]), nothing)
```
---
"""
function standardize_encoding(pipe::TokenizedNlpPipe; encoding::String = "ASCII")::TokenizedNlpPipe
    # Apply the processing function to each document
    processed_tokens = map(document -> map(token -> process_token(token, encoding), document), pipe.tokens)
    return TokenizedNlpPipe(pipe.corpus, processed_tokens, pipe.labels)
end

function process_token(token::String, encoding::String)::String
    # Replace invalid tokens with <UNK>
    if encoding == "ASCII" && !isascii(token) return "<UNK>"
    elseif encoding == "UTF-8" && !isvalid(token) return "<UNK>"
    else return token
    end
end

export standardization
