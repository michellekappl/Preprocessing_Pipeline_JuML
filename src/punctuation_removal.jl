
# ╔═╡ 80f24360-b60f-11ef-1017-652e59097489
# Eingabe ist eine Liste von zusammenhängenden Strings (Sätzen)
# Satzzeichen, Klammern und Anführungszeichen werden entfernt
function clean_text(text::AbstractString)::AbstractString
    return replace(text, r"[[:punct:](){}[\]\"']" => "")
end

# ╔═╡ 9710b080-ea41-42ff-8b91-50c88ea94206
# Eingabe ist Liste bestehend aus Tokens
function clean_tokens(tokens::Vector{String})::Vector{String}
    clean_token(token) = replace(token, r"[[:punct:](){}[\]\"']" => "")
    return clean_token.(tokens)
end

export clean_text
export clean_tokens


# ╔═╡ Cell order:
# ╠═80f24360-b60f-11ef-1017-652e59097489
# ╠═efa5f071-ea3f-4cba-b336-5140442cd633
# ╠═c83dad14-fb41-41c1-b80d-4ff54067f832
# ╠═9710b080-ea41-42ff-8b91-50c88ea94206
# ╠═7b9e9e84-377a-44f0-8818-10a0317e83cb
# ╠═22f3c1fd-37e6-418d-a6f0-a5f8ee5f92fd
