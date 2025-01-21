"""
    remove_noise(pipe::NlpPipe)

Removes noise from the corpus. Noise includes HTML tags, URLs, email addresses, file paths, special characters, dates & times.

# Arguments
- pipe::NlpPipe: The `NlpPipe` object with a corpus to remove noise from

# Returns
- A new `NlpPipe` object with the noise removed from the corpus
"""
function remove_noise(pipe::NlpPipe)::NlpPipe
   patterns = [
      r"<[^>]*>",                                        # HTML tags (very basic, just remove everything between < and >) TODO: Improve this
      r"https?:\/\/[^\s]+",                              # URLs
      r"www\.[^\s]+",                                    # URLs (starting with www)
      r"[A-Za-z]:\\[^\s]+|\/[^\s]+",                     # File paths
      r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}", # Emails
      r"#\w+",                                           # Hashtags
      r"\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b",              # Dates (MM/DD/YYYY or DD-MM-YY)
      r"\b\d{1,2}:\d{2}(?:AM|PM)?\b",                    # Times (e.g., 10:30 AM)
      r"[^a-zA-Z0-9\s]",                                 # Special characters
   ]

   corpus = pipe.corpus

   # Apply each regex to each document in the corpus
   for pattern in patterns
      corpus = map(doc -> replace(doc, pattern => ""), corpus)
   end

   return NlpPipe(corpus, pipe.labels)
end