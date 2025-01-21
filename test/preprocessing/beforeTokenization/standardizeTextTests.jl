test_corpus = [
   "Hello WoRlD, this is BIG",
   "He said: “What does ’monkey’ even mean?”"
]

@testset "Standardize Text Tests" begin
   pipe = NlpPipe(test_corpus) |> standardize_text

   @test pipe.corpus[1] == "hello world, this is big"
   @test pipe.corpus[2] == "he said: \"what does 'monkey' even mean?\""
end