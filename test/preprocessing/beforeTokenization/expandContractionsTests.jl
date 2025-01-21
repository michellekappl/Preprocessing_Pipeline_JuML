@testset "Expand Contractions Tests" begin
   corpus = [
      "You can't do that",
      "I wouldn't've done that",
      "You'dn't've done that either if you were me, but you're not",
   ]

   pipe = NlpPipe(corpus) |> standardize_text |> expand_contractions

   @test pipe.corpus[1] == "you cannot do that"
   @test pipe.corpus[2] == "i would not have done that"
   @test pipe.corpus[3] == "you would not have done that either if you were me, but you are not"
end
