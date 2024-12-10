### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ 80f24360-b60f-11ef-1017-652e59097489
# Eingabe ist eine Liste von zusammenhängenden Strings (Sätzen)
# Satzzeichen, Klammern und Anführungszeichen werden entfernt
function clean_text(text::AbstractString)::AbstractString
    return replace(text, r"[[:punct:](){}[\]\"']" => "")
end


# ╔═╡ efa5f071-ea3f-4cba-b336-5140442cd633
# Beispieleingabe
# was machen wir  mit den Zeichen "" innerhalb eines Strings?
texts = [
    "Giga{{{}}}, 'chad'!?!", 
    "Kenning West is a \"test\".", 
    "Let... him {cook}!! []?"
]

# ╔═╡ c83dad14-fb41-41c1-b80d-4ff54067f832
# Test 
cleaned_text = clean_text.(texts)

# ╔═╡ 9710b080-ea41-42ff-8b91-50c88ea94206
# Eingabe ist Liste bestehend aus Tokens
function clean_tokens(tokens::Vector{String})::Vector{String}
    clean_token(token) = replace(token, r"[[:punct:](){}[\]\"']" => "")
    return clean_token.(tokens)
end

# ╔═╡ 7b9e9e84-377a-44f0-8818-10a0317e83cb
# Beispieleingabe
tokens = ["Hello,", "'world'!", "This", "is", "a", "\"test\".", "Does", "it", "remove", "{all}", "[braces]", "and", "punctuation?"]

# ╔═╡ 22f3c1fd-37e6-418d-a6f0-a5f8ee5f92fd
# Test
cleaned_tokens = clean_tokens(tokens)

# ╔═╡ Cell order:
# ╠═80f24360-b60f-11ef-1017-652e59097489
# ╠═efa5f071-ea3f-4cba-b336-5140442cd633
# ╠═c83dad14-fb41-41c1-b80d-4ff54067f832
# ╠═9710b080-ea41-42ff-8b91-50c88ea94206
# ╠═7b9e9e84-377a-44f0-8818-10a0317e83cb
# ╠═22f3c1fd-37e6-418d-a6f0-a5f8ee5f92fd
