var documenterSearchIndex = {"docs":
[{"location":"getting_started/#Preprocessing*Pipeline*JuML","page":"Getting Started","title":"PreprocessingPipelineJuML","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"(Image: Stable) (Image: Dev) (Image: Coverage) <!– (Image: Build Status) –>","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"PreprocessingPipelineJuML is a Julia package for preprocessing text data in NLP pipelines.","category":"page"},{"location":"getting_started/#Installation-in-REPL","page":"Getting Started","title":"Installation in REPL","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Clone the repository and include the package in your Julia environment:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"git clone git@github.com:michellekappl/Preprocessing_Pipeline_JuML.git\ncd path/to/dir/Preprocessing_Pipeline_JuML","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Then, activate the package in Julia:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"using Pkg\nPkg.activate(\".\") \nPkg.instantiate()\nusing Preprocessing_Pipeline_JuML","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"This will install the required dependencies and make the package available in your Julia REPL.","category":"page"},{"location":"getting_started/#Features","page":"Getting Started","title":"Features","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Noise Removal: Strip away unwanted elements like HTML tags, URLs, emails, file paths, etc.\nTokenization: Split text into words or characters.\nVectorization: Transform text into machine-learning-compatible vector representations (currently only one-hot encoding supported)","category":"page"},{"location":"getting_started/#API-Structure","page":"Getting Started","title":"API Structure","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"The package provides a set of pipeline stages that can be chained together to preprocess text data. The pipeline stages are implemented as functions that take a NlpPipe or TokenizedNlpPipe struct as input and return a modified object of the same type. This makes it easy to build custom preprocessing pipelines by piping together the desired stages.","category":"page"},{"location":"getting_started/#Usage-Example:","page":"Getting Started","title":"Usage Example:","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"corpus = [\"Hello, world!\", \"How are you?\"]\npipe = NlpPipe(corpus) |> remove_noise |> tokenize |> one_hot_encoding\n# Output: VectorizedNlpPipe with one-hot encoded tokens","category":"page"},{"location":"getting_started/#Pipe-Objects:","page":"Getting Started","title":"Pipe Objects:","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"NlpPipe First struct to instantiate in a pipeline. Can be created directly from a text corpus. Can be ","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"used in preprocessing stages that do not require the text to be tokenized.\ntransformed into a TokenizedNlpPipe by applying the tokenize function.","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"TokenizedNlpPipe Struct that holds tokenized text data. Can be used for preprocessing stages that require tokenized text (e.g., stopword removal, stemming, etc.). Can be transformed into a VectorizedNlpPipe by applying any vectorization function.","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"VectorizedNlpPipe Struct that holds vectorized text data (embeddings). Can be used for machine learning tasks.","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"(Image: Pipeline Diagram)","category":"page"},{"location":"getting_started/#Quickstart","page":"Getting Started","title":"Quickstart","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Load the package:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"using Preprocessing_Pipeline_JuML","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Prepare a test corpus: Define a set of noisy text samples for preprocessing:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"test_corpus = [\n   \"Hello <b>world</b>! Visit http://example.com.\",\n   \"Email me: test@example.com or call +123-456-7890.\",\n   \"Today is 12/25/2024, time now: 10:30AM.\",\n   \"My file is at C:\\\\Users\\\\JohnDoe\\\\Documents\\\\file.txt.\",\n   \"Check this out: www.awesome-website.org/about-us.html!\",\n   \"#JuliaLang is great. Follow us @JuliaNLP.\"\n]","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Build your pipeline:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"pipe = NlpPipe(test_corpus) |> remove_noise |> tokenize |> one_hot_encoding","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Inspect the pipeline outputs:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Get the tokenized representation:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"println(pipe.tokens)","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"View the vocabulary generated during vectorization:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"println(pipe.vocabulary)","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"<!– ## License","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"This project is licensed under the MIT License. See the LICENSE file for details. –>","category":"page"},{"location":"getting_started/#**Feedback**","page":"Getting Started","title":"Feedback","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"If you encounter any issues or have feature requests, please open an issue in the repository. We appreciate your feedback!","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = Preprocessing_Pipeline_JuML","category":"page"},{"location":"#Preprocessing*Pipeline*JuML","page":"Home","title":"PreprocessingPipelineJuML","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for PreprocessingPipelineJuML.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [Preprocessing_Pipeline_JuML]","category":"page"},{"location":"#Preprocessing_Pipeline_JuML.expand_contractions-Tuple{NlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.expand_contractions","text":"expand_contractions(input::NlpPipe) -> NlpPipe\n\nExpand contractions in the input text. This function expands common English contractions.\n\nArguments\n\ninput::NlpPipe: A NlpPipe object containing the corpus to expand contractions in.\n\nReturns\n\noutput::NlpPipe: A new NlpPipe object with the contractions expanded in the corpus.\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.get_vocab_dict-Tuple{Any}","page":"Home","title":"Preprocessing_Pipeline_JuML.get_vocab_dict","text":"get_vocab_dict(vocab)\n\nCreate a Dict with idx in vector as values and words as keys\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.mask_numbers-Tuple{NlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.mask_numbers","text":"number_to_word(input)\n\nAllows user to preprocess numbers within a string. Each number, independent of length gets replaced with word: *number*, \ninputs: Strings and Vector{String}\noutput: Strings and Vector{String} respectively\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.one_hot_encoding-Tuple{TokenizedNlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.one_hot_encoding","text":"one_hot_encoding(x)\n\nCreate a one-hot-encoding out of given TokenizedNlpPipe\n\n#Examples:\n```julia-repl\njulia> pipe = TokenizedNlpPipe([[\"I\", \"love\", \"Julia\"], [\"Julia\", \"is\", \"awesome\"]])\njulia> one_hot(pipe)\nVectorizedNlpPipe([[[1 0 0 0 0; 0 1 0 0 0; 0 0 1 0 0], [0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1]]], Dict(\"love\" => 2, \"Julia\" => 3, \"I\" => 1, \"is\" => 4, \"awesome\" => 5))\n```\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.remove_noise-Tuple{NlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.remove_noise","text":"remove_noise(pipe::NlpPipe)\n\nRemoves noise from the corpus. Noise includes HTML tags, URLs, email addresses, file paths, special characters, dates & times.\n\nArguments\n\npipe::NlpPipe: The NlpPipe object with a corpus to remove noise from\n\nReturns\n\nA new NlpPipe object with the noise removed from the corpus\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.remove_stop_words-Tuple{TokenizedNlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.remove_stop_words","text":"remove_stop_words(pipe::TokenizedNlpPipe; language::String=\"en\", stop_words::Set{String}=Set{String}())\n\nRemoves predefined stopwords. You can access the stop words for a given language using the language name or ISO 639 code.  For example, to get the stop words for English, you can use stopwords[\"eng\"], stopwords[\"en\"], or stopwords[\"English\"].\n\nStop words sourced from https://github.com/guo-yong-zhi/StopWords.jl/blob/main/README.md.\n\nParameters\n\npipe: TokenizedNlpPipe\nlanguage: String = \"en\"\nstop_words: Set{String} = Set{String}()\n\nReturns\n\nA new TokenizedNlpPipestruct with the stop words removed from the tokens.\n\nExamples\n\nNlpPipe([\"This is a test\"]) |> tokenize |> remove_stop_words |> pipe -> pipe.tokens # [[\"This\", \"test\"]]\nNlpPipe([\"This is a test\"]) |> tokenize |> remove_stop_words(stop_words=[\"test\"]) |> pipe -> pipe.tokens # [[\"This\", \"is\", \"a\"]]\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.standardize_text-Tuple{NlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.standardize_text","text":"standardize_text(input::NlpPipe)\n\nStandardizes the text by converting it to lowercase and replacing unusual characters with their standard counterparts.\n\n\n\n\n\n","category":"method"}]
}
