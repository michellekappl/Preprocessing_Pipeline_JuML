using Preprocessing_Pipeline_JuML
using Test

include("pipes/NlpPipeTests.jl")
include("pipes/TokenizedNlpPipeTests.jl")

test_corpus = [
    "Hello <b>world</b>! Visit http://example.com.",
    "Email me: test@example.com or call +123-456-7890.",
    "Today is 12/25/2024, time now: 10:30AM.",
    "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.",
    "Check this out: www.awesome-website.org/about-us.html!",
    "#JuliaLang is great. Follow us."
]

test_corpus_string = join(test_corpus, "\n")

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

    @testset "mask_numbers" begin
        test_corpus = [
            "I have 5 apples and 10 oranges.",
            "The price is \$12.50. Where does the 1/2 € come from?",
            "The year is 2024."
        ]

        # test without a custom replace value → should be [NUM]
        pipe = NlpPipe(test_corpus) |> mask_numbers

        @test pipe.corpus[1] == "I have [NUM] apples and [NUM] oranges."
        @test pipe.corpus[2] == "The price is \$[NUM]. Where does the [NUM]/[NUM] € come from?"
        @test pipe.corpus[3] == "The year is [NUM]."

        # test with a custom replace value
        pipe = NlpPipe(test_corpus) |> pipe -> mask_numbers(pipe; replace_with="NUMBER")

        @test pipe.corpus[1] == "I have NUMBER apples and NUMBER oranges."
        @test pipe.corpus[2] == "The price is \$NUMBER. Where does the NUMBER/NUMBER € come from?"
        @test pipe.corpus[3] == "The year is NUMBER."
    end
end
