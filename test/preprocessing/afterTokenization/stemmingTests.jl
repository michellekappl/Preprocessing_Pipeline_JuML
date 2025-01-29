test_corpus_english = [
   "This is a test for stemming",
   "The dogs are running in the park",
]
test_corpus_german = [
   "Das ist ein Test",
   "Die Hunde rennen im Park",
]
custom_lang = "de"

@testset "Stemming Tests" begin
    # ----------------------------------------------------------------
    # Test with default language (English)
    # ----------------------------------------------------------------
    pipe = NlpPipe(test_corpus_english) |> tokenize |> stemming
    
    @test pipe.tokens == [["This", "is", "a", "test", "for", "stem"], ["The", "dog", "are", "run", "in", "the", "park"]]
    
    # ----------------------------------------------------------------
    # Test with custom language (German)
    # ----------------------------------------------------------------
    pipe = NlpPipe(test_corpus_german) |> tokenize |> pipe -> stemming(pipe; language=custom_lang)
    
    @test pipe.tokens == [["Das", "ist", "ein", "Test"], ["Die", "Hund", "renn", "im", "Park"]]
end