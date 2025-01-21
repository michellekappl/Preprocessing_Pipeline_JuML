@testset "BagOfNGrams Tests" begin
    # -----------------------------------------------------
    # Test 1: Basic functionality with bigrams
    # -----------------------------------------------------
    pipe = TokenizedNlpPipe(["one sentence sample", "two sentence sample"],[["one", "sentence", "sample"], ["two", "sentence", "sample"]], nothing)
    result = bag_of_ngrams(pipe, n= 2)
    expected_vocab = Dict("one sentence" => 1, "sentence sample" => 2, "two sentence" => 3)
    expected_vectorized = [
        [1 0 0; 0 1 0],
        [0 0 1; 0 1 0]
    ]
    @test result.vocabulary == expected_vocab
    @test result.tokens == expected_vectorized

    # -----------------------------------------------------
    # Test 2: Unigrams
    # -----------------------------------------------------
    pipe = TokenizedNlpPipe(["one sentence sample", "two sentence sample"],[["one", "sentence", "sample"], ["two", "sentence", "sample"]], nothing)
    result = bag_of_ngrams(pipe, n= 1)
    expected_vocab = Dict("one" => 1, "sentence" => 2, "sample" => 3, "two" => 4)
    expected_vectorized = [
        [1 0 0 0; 0 1 0 0; 0 0 1 0],
        [0 0 0 1; 0 1 0 0; 0 0 1 0]
    ]
    @test result.vocabulary == expected_vocab
    @test result.tokens == expected_vectorized

    # -----------------------------------------------------
    # Test 3: Trigrams
    # -----------------------------------------------------
    pipe = TokenizedNlpPipe(["one sentence sample", "two sentence sample"], [["one", "sentence", "sample"], ["two", "sentence", "sample"]], nothing)
    result = bag_of_ngrams(pipe, n= 3)
    expected_vocab = Dict("one sentence sample" => 1, "two sentence sample" => 2)
    expected_vectorized = [
        [1 0],
        [0 1]
    ]
    @test result.vocabulary == expected_vocab
    @test result.tokens == expected_vectorized

    # -----------------------------------------------------
    # Test 4: ngrams too large for the corpus
    # -----------------------------------------------------
    pipe = TokenizedNlpPipe(["one sentence sample", "two sentence sample"], [["one", "sentence", "sample"], ["two", "sentence", "sample"]], nothing)
    result = bag_of_ngrams(pipe, n=4)
    expected_vocab = Dict("one sentence sample <PAD>" => 1, "two sentence sample <PAD>" => 2)
    expected_vectorized = [
        [1 0],
        [0 1]
    ]
    @test result.vocabulary == expected_vocab
    @test result.tokens == expected_vectorized

end
