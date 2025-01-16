test_corpus = [
   "Hi, my name is John Smith",
   "This sentence was written by Jane Doe",
   "What do the eggs cost? '2.50€' is the answer.",
]

test_corpus_string = join(test_corpus, "\n")

test_labels = ["a", "b", "c"]

@testset "TokenizedNlpPipe Tests" begin
   pipe = NlpPipe(test_corpus, test_labels) |> tokenize

   # Tokenization should not change the corpus or labels
   @test pipe.corpus === test_corpus
   @test pipe.labels == test_labels

   # Vocabulary should be a Set that contains all unique tokens
   @test pipe.vocabulary == Set([
      "Hi,", "my", "name", "is", "John", "Smith", 
      "This", "sentence", "was", "written", "by", "Jane", "Doe", 
      "What", "do", "the", "eggs", "cost?", "'2.50€'", "answer."
   ])

   # Default tokenizer should be word level
   @test pipe.tokens[1] == ["Hi,", "my", "name", "is", "John", "Smith"]
   @test pipe.tokens[2] == ["This", "sentence", "was", "written", "by", "Jane", "Doe"]
   @test pipe.tokens[3] == ["What", "do", "the", "eggs", "cost?", "'2.50€'", "is", "the", "answer."]

   # Test character level tokenizer
   pipe = NlpPipe(test_corpus) |> pipe -> tokenize(pipe, :character)
   @test pipe.tokens[1] == ["H", "i", ",", " ", "m", "y", " ", "n", "a", "m", "e", " ", "i", "s", " ", "J", "o", "h", "n", " ", "S", "m", "i", "t", "h"]

   # Invalid tokenization level should throw an error
   @test_throws ArgumentError tokenize(NlpPipe(test_corpus), :invalid)
end