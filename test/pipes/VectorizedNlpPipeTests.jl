@testset "VectorizedNlpPipe Tests" begin
   # ---------------------------------------------------------
   # Test construction of VectorizedNlpPipe from scratch
   # ---------------------------------------------------------
   tokens = [[1 2; 3 4], [5 6; 7 8]]  # Example word embeddings
   vocab = Dict("hello" => 1, "world" => 2, "Julia" => 3)
   labels = ["greeting", "statement"]

   pipe = VectorizedNlpPipe(tokens, vocab, labels)

   @test pipe.tokens == tokens
   @test pipe.vocabulary == vocab
   @test pipe.labels == labels

   # ---------------------------------------------------------
   # Test construction without labels
   # ---------------------------------------------------------
   pipe_no_labels = VectorizedNlpPipe(tokens, vocab, nothing)

   @test pipe_no_labels.tokens == tokens
   @test pipe_no_labels.vocabulary == vocab
   @test pipe_no_labels.labels === nothing

   # ---------------------------------------------------------
   # Test that the vocabulary maps correctly
   # ---------------------------------------------------------
   expected_vocab_keys = Set(["hello", "world", "Julia"])
   @test Set(keys(pipe.vocabulary)) == expected_vocab_keys

   # ---------------------------------------------------------
   # Test tokens are of correct type and structure
   # ---------------------------------------------------------
   @test all(t -> t isa Matrix{Int}, pipe.tokens)
   @test size(pipe.tokens[1]) == (2, 2)
   @test size(pipe.tokens[2]) == (2, 2)

   # ---------------------------------------------------------
   # Test edge cases: Empty tokens or vocabulary
   # ---------------------------------------------------------
   empty_pipe = VectorizedNlpPipe([], Dict(), nothing)
   @test isempty(empty_pipe.tokens)
   @test isempty(empty_pipe.vocabulary)
   @test empty_pipe.labels === nothing

   # ---------------------------------------------------------
   # Test invalid inputs
   # ---------------------------------------------------------
   @test_throws MethodError VectorizedNlpPipe("invalid_tokens", vocab, labels)  # Invalid tokens
   @test_throws MethodError VectorizedNlpPipe(tokens, "invalid_vocab", labels)  # Invalid vocabulary
   @test_throws MethodError VectorizedNlpPipe(tokens, vocab, "invalid_labels")  # Invalid labels
end
