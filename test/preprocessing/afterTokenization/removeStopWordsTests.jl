@testset "Remove Stop Words Tests" begin
   corpus = ["Dies ist ein Test", "Das ist nur ein anderer Satz mit Worten"]
   language = "de"
   custom_stop_words = Set(["Satz", "Test", "Worten"])

   # Not setting language defaults to English → no change should be visible with German content
   @test NlpPipe(corpus) |> 
      tokenize |> 
      remove_stop_words |> 
      pipe -> pipe.tokens == [["Dies", "ist", "ein", "Test"], ["Das", "ist", "nur", "ein", "anderer", "Satz", "mit", "Worten"]]

   # Setting the language to German should remove the German stop words
   @test NlpPipe(corpus) |> 
      tokenize |> 
      pipe -> remove_stop_words(pipe; language=language) |> 
      pipe -> pipe.tokens == [["Dies", "Test"], ["Das", "Satz", "Worten"]]

   # Custom stop words should replace the default stop words
   @test NlpPipe(corpus) |> 
      tokenize |> 
      pipe -> remove_stop_words(pipe; stop_words=custom_stop_words) |> 
      pipe -> pipe.tokens == [["Dies", "ist", "ein"], ["Das", "ist", "nur", "ein", "anderer", "mit"]]
end