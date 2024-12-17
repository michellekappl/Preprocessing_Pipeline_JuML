using Preprocessing_Pipeline_JuML
using Test

@testset "Preprocessing_Pipeline_JuML.jl" begin

    @testset "remove_noise" begin
        test_corpus = [
            "Hello <b>world</b>! Visit http://example.com.",
            "Email me: test@example.com or call +123-456-7890.",
            "Today is 12/25/2024, time now: 10:30AM.",
            "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.",
            "Check this out: www.awesome-website.org/about-us.html!",
            "#JuliaLang is great. Follow us."
        ]

        pipe = NlpPipe(test_corpus) |> remove_noise

        @test pipe.corpus[1] == "Hello world Visit "
        @test pipe.corpus[2] == "Email me  or call 1234567890"
        @test pipe.corpus[3] == "Today is 12 time now "
        @test pipe.corpus[4] == "My file is at "
        @test pipe.corpus[5] == "Check this out "
        @test pipe.corpus[6] == " is great Follow us"
    end

    @testset "tokenize" begin
        test_corpus = [
            "This is a document It has multiple sentences",
            "Here is another one"
        ]

        pipe = NlpPipe(test_corpus) |> tokenize

        # Default tokenizer should be word level
        @test pipe.tokens[1] == ["This", "is", "a", "document", "It", "has", "multiple", "sentences"]
        @test pipe.tokens[2] == ["Here", "is", "another", "one."]

        @enum TokenizeLevel character word

        # Test character level tokenizer
        pipe = NlpPipe(test_corpus) |> pipe -> tokenize(pipe, character)
        @test pipe.tokens[1] == ["T", "h", "i", "s", " ", "i", "s", " ", "a", " ", "d", "o", "c", "u", "m", "e", "n", "t", ".", " ", "I", "t", " ", "h", "a", "s", " ", "m", "u", "l", "t", "i", "p", "l", "e", " ", "s", "e", "n", "t", "e", "n", "c", "e", "s", "."]
        @test pipe.tokens[2] == ["H", "e", "r", "e", " ", "i" , "s", " ", "a", "n", "o", "t", "h", "e", "r", " ", "o", "n", "e", "."]
    end

    # TODO Add more tests
end
