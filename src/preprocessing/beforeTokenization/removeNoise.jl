default_patterns::Vector{Pair{Regex, String}} = [
   r"<[^>]*>" => "",                                               # HTML tags (very basic, just remove everything between < and >) TODO: Improve this
   r"\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b" => "<DATE>",               # Dates (MM/DD/YYYY or DD-MM-YY)
   r"\b\d{1,2}:\d{2}(?:AM|PM)?\b" => "<TIME>",                     # Times (e.g., 10:30 AM)
   r"https?:\/\/[^\s]+" => "<URL>",                                # URLs
   r"www\.[^\s]+" => "<URL>" ,                                     # URLs (starting with www)
   r"[A-Za-z]:\\[^\s]+|\/[^\s]+" => "<PATH>",                      # File paths
   r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" => "<EMAIL>", # Emails
   r"#\w+" => "",                                                  # Hashtags
   r"[^a-zA-Z0-9\s<>]" => "",                                      # Special characters (except for < and >, which are used as replacement tokens)
]

"""
   remove_noise(pipe::NlpPipe)

Removes noise from the corpus. Noise includes HTML tags, URLs, email addresses, file paths, special characters, dates & times.

# Arguments
- pipe::NlpPipe: The `NlpPipe` object with a corpus to remove noise from

# Returns
- A new `NlpPipe` object with the noise removed from the corpus
"""
function remove_noise(pipe::NlpPipe; replacement_patterns::Vector{Pair{Regex, String}} = default_patterns)::NlpPipe
   corpus = pipe.corpus

   @info pairs(replacement_patterns)

   # Apply each regex to each document in the corpus
   for (pattern, replacement) in replacement_patterns
      corpus = map(doc -> replace(doc, pattern => replacement), corpus)
   end

   return NlpPipe(corpus, pipe.labels)
end