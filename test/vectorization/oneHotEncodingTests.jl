@testset "OneHotEncoding Tests" begin
    # Test case 1
    pipe = TokenizedNlpPipe(["I love Julia", "Julia is awesome"], [["I", "love", "Julia"], ["Julia", "is", "awesome"]], nothing)
    result = one_hot_encoding(pipe)
    expected_tokens = 
    [
        [1 0 0 0 0; 0 0 0 0 1; 0 0 0 1 0],
        [0 0 0 1 0; 0 0 1 0 0; 0 1 0 0 0]
    ]
    expected_vocab_dict = Dict("I" => 1, "awesome" => 2, "is" => 3, "Julia" => 4, "love" => 5)
    @test result.tokens == expected_tokens
    @test result.vocabulary == expected_vocab_dict
end