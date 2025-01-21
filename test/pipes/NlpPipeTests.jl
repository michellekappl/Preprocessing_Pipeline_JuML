test_corpus = [
   "Hi, my name is John Smith",
   "This sentence was written by Jane Doe",
   "What do the eggs cost? '2.50€' is the answer.",
]

test_corpus_string = join(test_corpus, "\n")

@testset "NlpPipe Tests" begin
   # ------------------------------------------------------------------
   # Test construction of NlpPipe from a corpus with multiple documents
   # ------------------------------------------------------------------
   pipe1 = NlpPipe(test_corpus)
   @test pipe1.corpus === test_corpus
   @test pipe1.labels === nothing

   # ------------------------------------------------------------------
   # Test construction of NlpPipe from a single string corpus
   # ------------------------------------------------------------------
   pipe2 = NlpPipe(test_corpus_string)
   @test pipe2.corpus == [test_corpus_string]
   @test pipe2.labels === nothing

   # ------------------------------------------------------------------
   # Test construction of NlpPipe with associated labels
   # ------------------------------------------------------------------
   pipe3 = NlpPipe(test_corpus, ["a", "b", "c"])
   @test pipe3.labels == ["a", "b", "c"]

   # ------------------------------------------------------------------
   # Test that the NlpPipe can be constructed from a previous pipe
   # ------------------------------------------------------------------
   pipe4 = NlpPipe(pipe3)
   @test pipe4.corpus == pipe3.corpus
   @test pipe4.labels == pipe3.labels

   # -------------------------------------------------------------------
   # If we pass new labels to the pipe and the dimensions don't 
   # match the corpus, an error should be thrown (and vice-versa)
   # -------------------------------------------------------------------
   @test_throws ArgumentError pipe5 = NlpPipe(pipe4; labels=["f", "g", "h", "i", "j"])
   @test_throws ArgumentError pipe6 = NlpPipe(pipe4; corpus=["f", "g", "h", "i", "j"])

   # -------------------------------------------------------------------
   # Same error should be thrown when initializing completely new pipe
   # -------------------------------------------------------------------
   @test_throws ArgumentError pipe7 = NlpPipe(["f", "g", "h", "i", "j"], ["a", "b", "c"])
end