@testset "Bag of Words Tests" begin
    # -----------------------------------------------------
    # Test 1: Multiple documents
    # -----------------------------------------------------
    pipe = TokenizedNlpPipe(["I love Julia", "Julia is awesome"],[["I", "love", "Julia"], ["Julia", "is", "awesome"]], nothing)
    result = bag_of_words(pipe)
    expected_tokens = 
    [
        [1 0 0 1 1],
        [0 1 1 1 0]
    ]
    expected_vocab = Dict("I" => 1, "awesome" => 2, "is" => 3, "Julia" => 4, "love" => 5)
    
    @test result.tokens == expected_tokens
    @test result.vocabulary == expected_vocab

    # -----------------------------------------------------
    # Test 2: Single document
    # -----------------------------------------------------
    pipe = TokenizedNlpPipe(["Julia is great"],[["Julia", "is", "great"]], nothing)
    result = bag_of_words(pipe)
    expected_tokens = [Matrix{Int}([1 1 1])]
    expected_vocab = Dict("great" => 1, "is" => 2, "Julia" => 3)

    @test result.tokens == expected_tokens
    @test result.vocabulary == expected_vocab
end