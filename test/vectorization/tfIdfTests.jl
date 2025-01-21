@testset "TF-IDF Tests" begin

    # Test 1: Basic functionality
    pipe = TokenizedNlpPipe(
        ["I love Julia", "Julia is awesome"],
        [["I", "love", "Julia"], ["Julia", "is", "awesome"]],
        nothing
    )
    result = tf_idf(pipe)
    v = log(2) / 3
    expected_tokens = [
        [v 0 0 0 0;
         0 v 0 0 0;
         0 0 0 0 0],
        [0 0 0 0 0;
         0 0 0 v 0;
         0 0 0 0 v]
    ]
    expected_vocab = Dict("I" => 1, "love" => 2, "Julia" => 3, "is" => 4, "awesome" => 5)
    @test length(result.tokens) == 2
    @test isapprox(result.tokens[1], expected_tokens[1], atol=1e-6)
    @test isapprox(result.tokens[2], expected_tokens[2], atol=1e-6)
    @test result.vocabulary == expected_vocab

    # Test 2: Raw TF + Smooth IDF
    pipe = TokenizedNlpPipe(
        ["Quick test", "Another quick test"],
        [["Quick", "test"], ["Another", "quick", "test"]],
        nothing
    )
    result = tf_idf(
        pipe,
        tf_weighting="raw term frequency",
        idf_weighting="smooth inverse document frequency"
    )
    # Basic checks: shapes and vocabulary
    @test length(result.tokens) == 2
    @test size(result.tokens[1], 1) == 2
    @test size(result.tokens[2], 1) == 3
    @test haskey(result.vocabulary, "Quick")
    @test haskey(result.vocabulary, "quick")
    @test haskey(result.vocabulary, "Another")
end