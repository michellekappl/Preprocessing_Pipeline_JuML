test_corpus = [
   "Hello <b>world</b>! Visit http://example.com.",
   "Email me: test@example.com or call +123-456-7890.",
   "Today is 12/25/2024, time now: 10:30AM.",
   "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.",
   "Check this out: www.awesome-website.org/about-us.html!",
   "#JuliaLang is great. Follow us."
]

@testset "Remove Noise Tests" begin
   # ----------------------------------------------------------------
   # Test with default replacement patterns
   # ----------------------------------------------------------------
   pipe = NlpPipe(test_corpus) |> remove_noise

   @test pipe.corpus == [
      "Hello world Visit <URL>",
      "Email me <EMAIL> or call 1234567890",
      "Today is <DATE> time now <TIME>",
      "My file is at <PATH>",
      "Check this out <URL>",
      " is great Follow us"
   ]

   custom_replacement_patterns = [
      r"JuliaLang" => "JUL1@",
      r"My file is at" => "This is a Julia test",
   ]

   # ----------------------------------------------------------------
   # Test with custom replacement patterns
   # ----------------------------------------------------------------
   pipe = NlpPipe(test_corpus) |> pipe -> remove_noise(pipe; replacement_patterns = custom_replacement_patterns)

   @test pipe.corpus == [
      "Hello <b>world</b>! Visit http://example.com.",
      "Email me: test@example.com or call +123-456-7890.",
      "Today is 12/25/2024, time now: 10:30AM.",
      "This is a Julia test C:\\Users\\JohnDoe\\Documents\\file.txt.",
      "Check this out: www.awesome-website.org/about-us.html!",
      "#JUL1@ is great. Follow us."
   ]
end