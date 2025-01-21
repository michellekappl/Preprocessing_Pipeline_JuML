@testset "Mask Numbers Tests" begin
   corpus = [
      "I have 5 apples and 10 oranges.",
      "The price is \$12.50. Where does the 1/2 € come from?",
      "The year is 2024."
   ]

   # test without a custom replace value → should be <NUM>
   pipe = NlpPipe(corpus) |> mask_numbers
   @test pipe.corpus[1] == "I have <NUM> apples and <NUM> oranges."
   @test pipe.corpus[2] == "The price is \$<NUM>. Where does the <NUM>/<NUM> € come from?"
   @test pipe.corpus[3] == "The year is <NUM>."

   # test with a custom replace value
   pipe = NlpPipe(corpus) |> pipe -> mask_numbers(pipe; replace_with="NUMBER")
   @test pipe.corpus[1] == "I have NUMBER apples and NUMBER oranges."
   @test pipe.corpus[2] == "The price is \$NUMBER. Where does the NUMBER/NUMBER € come from?"
   @test pipe.corpus[3] == "The year is NUMBER."
end