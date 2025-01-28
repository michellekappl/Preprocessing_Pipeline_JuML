# Example corpus for testing
corpus = [
   "I have 5 apples and 10 oranges.",
   "The price is 12.50. Where does the 1/2 € come from?",
   "The year is 2024."
]

@testset "Standardize Encoding Tests" begin
   # -----------------------------------------------------
   # Test replacing invalid tokens with <UNK> for ASCII encoding
   # This tests non-ASCII characters like 😄, which should be replaced by <UNK>
   # -----------------------------------------------------
   pipe = NlpPipe(["I love programming 💻", "This is fun! 😄"]) |> tokenize |> standardize_encoding
   @test pipe.corpus == ["I love programming 💻", "This is fun! 😄"]  # Corpus should remain the same
   @test pipe.tokens[1] == ["I", "love", "programming", "<UNK>"]  # 💻 is replaced with <UNK>
   @test pipe.tokens[2] == ["This", "is", "fun!", "<UNK>"]  # 😄 is replaced with <UNK>

   # -----------------------------------------------------
   # Test with UTF-8 encoding for the same corpus
   # UTF-8 encoding should retain all special characters like 💻 and 😄
   # -----------------------------------------------------
   pipe = NlpPipe(["I love programming 💻", "This is fun! 😄"]) |> tokenize |> pipe -> standardize_encoding(pipe, encoding="UTF-8")
   @test pipe.corpus == ["I love programming 💻", "This is fun! 😄"]
   @test pipe.tokens[1] == ["I", "love", "programming", "💻"]
   @test pipe.tokens[2] == ["This", "is", "fun!", "😄"]
end
