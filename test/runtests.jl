using Preprocessing_Pipeline_JuML
using Test

test_corpus = [
    "Hello <b>world</b>! Visit http://example.com.",
    "Email me: test@example.com or call +123-456-7890.",
    "Today is 12/25/2024, time now: 10:30AM.",
    "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.",
    "Check this out: www.awesome-website.org/about-us.html!",
    "#JuliaLang is great. Follow us."
]

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
            "Here is another one",
            "abc"
        ]

        pipe = NlpPipe(test_corpus) |> tokenize

        # Default tokenizer should be word level
        @test pipe.tokens[1] == ["This", "is", "a", "document", "It", "has", "multiple", "sentences"]
        @test pipe.tokens[2] == ["Here", "is", "another", "one"]

        # Test character level tokenizer
        pipe = NlpPipe(test_corpus) |> pipe -> tokenize(pipe, :character)
        @test pipe.tokens[3] == ["a", "b", "c"]

        # Invalid tokenization level should throw an error
        @test_throws ArgumentError tokenize(NlpPipe(test_corpus), :invalid)
    end

    @testset "numbers_to_words" begin
        test_corpus = [
            "I have 5 apples and 10 oranges.",
            "The price is \$12.50. Where does the 1/2 € come from?",
            "The year is 2024."
        ]

        # test without a custom replace value → should be [NUM]
        pipe = NlpPipe(test_corpus) |> number_to_word

        @test pipe.corpus[1] == "I have [NUM] apples and [NUM] oranges."
        @test pipe.corpus[2] == "The price is \$[NUM]. Where does the [NUM]/[NUM] € come from?"
        @test pipe.corpus[3] == "The year is [NUM]."

        # test with a custom replace value
        pipe = NlpPipe(test_corpus) |> pipe -> number_to_word(pipe; replace_with="NUMBER")

        @test pipe.corpus[1] == "I have NUMBER apples and NUMBER oranges."
        @test pipe.corpus[2] == "The price is \$NUMBER. Where does the NUMBER/NUMBER € come from?"
        @test pipe.corpus[3] == "The year is NUMBER."
    end
end
