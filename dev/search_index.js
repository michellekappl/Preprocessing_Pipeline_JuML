var documenterSearchIndex = {"docs":
[{"location":"getting_started/#Installation-in-REPL","page":"Getting Started","title":"Installation in REPL","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Clone the repository and include the package in your Julia environment:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"git clone git@github.com:michellekappl/Preprocessing_Pipeline_JuML.git\ncd path/to/dir/Preprocessing_Pipeline_JuML","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Then, activate the package in Julia:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"using Pkg\nPkg.activate(\".\") \nPkg.instantiate()\nusing Preprocessing_Pipeline_JuML","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"This will install the required dependencies and make the package available in your Julia REPL.","category":"page"},{"location":"getting_started/#Quickstart","page":"Getting Started","title":"Quickstart","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"1. Load the package:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"using Preprocessing_Pipeline_JuML","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"2. Prepare a test corpus: Define a set of noisy text samples for preprocessing:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"test_corpus = [\n   \"Hello <b>world</b>! Visit http://example.com.\",\n   \"Email me: test@example.com or call +123-456-7890.\",\n   \"Today is 12/25/2024, time now: 10:30AM.\",\n   \"My file is at C:\\\\Users\\\\JohnDoe\\\\Documents\\\\file.txt.\",\n   \"Check this out: www.awesome-website.org/about-us.html!\",\n   \"#JuliaLang is great. Follow us @JuliaNLP.\"\n]","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"3. Build your pipeline:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"pipe = NlpPipe(test_corpus) |> remove_noise |> tokenize |> one_hot_encoding","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"4. Inspect the pipeline outputs:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"Get the tokenized representation:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"@info pipe.tokens # contains documents split into single tokens","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"5. View the vectors and vocabulary generated during vectorization:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"@info pipe.tokens # contains the tokens from before, but as numeric vectors\n@info pipe.vocabulary","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"<!– ## License","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"This project is licensed under the MIT License. See the LICENSE file for details. –>","category":"page"},{"location":"getting_started/#Run-the-tests","page":"Getting Started","title":"Run the tests","text":"","category":"section"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"To run the tests, open a Julia REPL, activate the project, and use the ] key to enter the package management console. Then, execute test to run the test suite. The output should look like this:","category":"page"},{"location":"getting_started/","page":"Getting Started","title":"Getting Started","text":"(@v1.6) pkg> test\nTesting:                    |   52     52  0.6s\n  NlpPipe Tests             |   10     10  0.1s\n  TokenizedNlpPipe Tests    |    8      8  0.1s\n  Remove Stop Words Tests   |    3      3  0.1s\n  Expand Contractions Tests |    3      3  0.1s\n  Mask Numbers Tests        |    6      6  0.0s\n  Remove Noise Tests        |    6      6  0.0s\n  Standardize Text Tests    |    2      2  0.0s\n  OneHotEncoding Tests      |    2      2  0.1s\n  Bag of Words Tests        |    4      4  0.0s\n  BagOfNGrams Tests         |    8      8  0.1s\n     Testing Preprocessing_Pipeline_JuML tests passed","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = Preprocessing_Pipeline_JuML","category":"page"},{"location":"#Preprocessing*Pipeline*JuML","page":"Home","title":"PreprocessingPipelineJuML","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Stable) (Image: Coverage) (Image: Build Status)","category":"page"},{"location":"","page":"Home","title":"Home","text":"PreprocessingPipelineJuML is a Julia package for preprocessing text data in NLP pipelines.","category":"page"},{"location":"#Features","page":"Home","title":"Features","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Text preprocessing: prepare textual data for machine learning tasks. Preprocessing steps include:\napplied before Tokenization:\nexpansion of contractions\nmasking of numbers\nnoise removal (punctuation, special characters, phone numbers, e-mail addresses, ...)\ntext standardization (handle encoding & lowercasing)\napplied after Tokenization:\nstopword removal\nstemming\nTokenization: Split text into words or characters.\nVectorization: Transform text into machine-learning-compatible vector representations\none-hot encoding\nBag of Words (BoW)\nBag of N-Grams\nTerm Frequency-Inverse Document Frequency (TF-IDF)","category":"page"},{"location":"#API-Structure","page":"Home","title":"API Structure","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The package provides a set of pipeline stages that can be chained together to preprocess text data. The pipeline stages are implemented as functions that take a NlpPipe or TokenizedNlpPipe struct as input and return a modified object of the same type. This makes it easy to build custom preprocessing pipelines by piping together the desired stages.","category":"page"},{"location":"#Usage-Example:","page":"Home","title":"Usage Example:","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"corpus = [\"Hello, world!\", \"How are you?\"]\npipe = NlpPipe(corpus) |> remove_noise |> tokenize |> one_hot_encoding\n# Output: VectorizedNlpPipe with one-hot encoded tokens","category":"page"},{"location":"#Pipe-Objects:","page":"Home","title":"Pipe Objects:","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"NlpPipe First struct to instantiate in a pipeline. Can be created directly from a text corpus. Can be ","category":"page"},{"location":"","page":"Home","title":"Home","text":"used in preprocessing stages that do not require the text to be tokenized.\ntransformed into a TokenizedNlpPipe by applying the tokenize function.","category":"page"},{"location":"","page":"Home","title":"Home","text":"TokenizedNlpPipe Struct that holds tokenized text data. Can be used for preprocessing stages that require tokenized text (e.g., stopword removal, stemming, etc.). Can be transformed into a VectorizedNlpPipe by applying any vectorization function.","category":"page"},{"location":"","page":"Home","title":"Home","text":"VectorizedNlpPipe Struct that holds vectorized text data (embeddings). Can be used for machine learning tasks.","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: Pipeline Diagram)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [Preprocessing_Pipeline_JuML]","category":"page"},{"location":"#Preprocessing_Pipeline_JuML.NlpPipe","page":"Home","title":"Preprocessing_Pipeline_JuML.NlpPipe","text":"NlpPipe\n\nA simple pipeline structure for handling text data (corpus) and corresponding labels.\n\nFields\n\ncorpus::Vector{String}: A collection of text documents.\nlabels::Union{Vector{String}, Nothing}: Optional labels corresponding to each document in corpus.\n\nConstructors\n\nNlpPipe(corpus::Vector{String}, labels::Union{Vector{String}, Nothing})    Creates an NlpPipe instance with a given corpus and optional labels.    Throws an ArgumentError if the number of documents and labels do not match.\nNlpPipe(corpus::Vector{String})    Creates an NlpPipe instance with only a corpus, setting labels to nothing.\nNlpPipe(corpus::String)    Creates an NlpPipe instance with a single document, storing it in a vector.\nNlpPipe(previousPipe::NlpPipe; corpus::Vector{String} = previousPipe.corpus, labels::Union{Vector{String}, Nothing} = previousPipe.labels)    Creates a new NlpPipe instance based on an existing one, optionally overriding corpus and labels.    Throws an ArgumentError if labels is not nothing and its length does not match the corpus length.\n\nExample Usage\n\nCreating a pipe from a corpus with multiple documents, inclusing labels\n\njulia> pipe1 = NlpPipe([\"document1\", \"document2\"], [\"label1\", \"label2\"])\nNlpPipe([\"document1\", \"document2\"], [\"label1\", \"label2\"])\n\n\n\nCreating a pipe from a corpus without labels\n\njulia> pipe2 = NlpPipe([\"document3\"])\nNlpPipe([\"document3\"], nothing)\n\n\n\nCreating a pipe from a single string corpus\n\njulia> pipe3 = NlpPipe(\"single document\") \nNlpPipe([\"single document\"], nothing)\n\n\n\nCreating a new pipe from an existing one with modified corpus and labels\n\njulia> NlpPipe(pipe1, corpus=[\"new_doc1\", \"new_doc2\"])\nNlpPipe([\"new_doc1\", \"new_doc2\"], [\"label1\", \"label2\"])\n\n\n\n\n\n\n\n","category":"type"},{"location":"#Preprocessing_Pipeline_JuML.TokenizedNlpPipe","page":"Home","title":"Preprocessing_Pipeline_JuML.TokenizedNlpPipe","text":"TokenizedNlpPipe\n\nA structure for handling tokenized text data, maintaining a vocabulary and optional labels.\n\nFields\n\ncorpus::Vector{String}: A collection of original text documents.\ntokens::Vector{Vector{String}}: Tokenized representation of each document in corpus.\nvocabulary::Set{String}: A set of unique tokens derived from tokens.\nlabels::Union{Vector{String}, Nothing}: Optional labels corresponding to each document.\n\nConstructors\n\nTokenizedNlpPipe(corpus::Vector{String}, tokens::Vector{Vector{String}}, labels::Union{Vector{String}, Nothing})    Creates a TokenizedNlpPipe instance with a given corpus, tokenized documents, and optional labels.    The vocabulary is automatically generated from tokens.\nTokenizedNlpPipe(previousPipe::TokenizedNlpPipe; tokens::Vector{Vector{String}} = previousPipe.tokens, vocabulary::Set{String} = previousPipe.vocabulary, labels::Union{Vector{String}, Nothing} = previousPipe.labels)    Creates a new TokenizedNlpPipe instance based on an existing one, allowing modifications to tokens, vocabulary, and labels while retaining the original corpus.\n\nExample Usage\n\n\n\nCreating a pipe from an NlpPipe instance (usual way to do it)\n\njulia> corpus = [\"Hello world\", \"Julia is great\"]\n2-element Vector{String}:\n \"Hello world\"\n \"Julia is great\"\njulia> tokenizedPipe = NlpPipe(corpus) |> tokenize\nTokenizedNlpPipe([\"Hello world\", \"Julia is great\"], [[\"Hello\", \"world\"], [\"Julia\", \"is\", \"great\"]], Set([\"great\", \"Hello\", \"is\", \"Julia\", \"world\"]), nothing)\n\n\n\nCreating a new pipe from scratch\n\njulia> corpus = [\"Hello world\", \"Julia is great\"]\n2-element Vector{String}:\n \"Hello world\"\n \"Julia is great\"\n\njulia> tokens = [[\"Hello\", \"world\"], [\"Julia\", \"is\", \"great\"]]\n2-element Vector{Vector{String}}:\n [\"Hello\", \"world\"]\n [\"Julia\", \"is\", \"great\"]\n \njulia> TokenizedNlpPipe(corpus, tokens, [\"greeting\", \"statement\"])\nTokenizedNlpPipe([\"Hello world\", \"Julia is great\"], [[\"Hello\", \"world\"], [\"Julia\", \"is\", \"great\"]], Set([\"great\", \"Hello\", \"is\", \"Julia\", \"world\"]), [\"greeting\", \"statement\"])\n\n\n\nCreating a new pipe from an existing one with modified tokens\n\njulia> pipe1 = TokenizedNlpPipe(corpus, tokens, [\"greeting\", \"statement\"])\nTokenizedNlpPipe([\"Hello world\", \"Julia is great\"], [[\"Hello\", \"world\"], [\"Julia\", \"is\", \"great\"]], Set([\"great\", \"Hello\", \"is\", \"Julia\", \"world\"]), [\"greeting\", \"statement\"])\n\njulia> pipe2 = TokenizedNlpPipe(pipe1; tokens=[[\"Hello\"], [\"Julia\", \"is\"]])\nTokenizedNlpPipe([\"Hello world\", \"Julia is great\"], [[\"Hello\"], [\"Julia\", \"is\"]], Set([\"great\", \"Hello\", \"is\", \"Julia\", \"world\"]), [\"greeting\", \"statement\"])\n\n\n\n\n\n\n\n","category":"type"},{"location":"#Preprocessing_Pipeline_JuML.VectorizedNlpPipe","page":"Home","title":"Preprocessing_Pipeline_JuML.VectorizedNlpPipe","text":"VectorizedNlpPipe\n\nA structure for handling vectorized representations of tokenized text data, including a vocabulary mapping and optional labels.\n\nFields\n\ntokens::Vector{Matrix{<:Union{Int, Float64}}}: A collection of numerical representations (e.g., embeddings, one-hot encodings) for tokenized text.\nvocabulary::Dict{String, Int}: A dictionary mapping words to unique integer indices.\nlabels::Union{Vector{String}, Nothing}: Optional labels corresponding to each document.\n\nExample Usage\n\n\n\nCreating a pipe from an existing TokenizedNlpPipe instance (usual way to do it)\n\njulia> corpus = [\"Hello world\", \"Julia is great\"]\n2-element Vector{String}:\n \"Hello world\"\n \"Julia is great\"\n\njulia> NlpPipe(corpus) |> tokenize |> one_hot_encoding # (or any other vectorization method)\nVectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[0 1 … 0 0; 0 0 … 0 1], [0 0 … 1 0; 0 0 … 0 0; 1 0 … 0 0]], Dict(\"great\" => 1, \"Hello\" => 2, \"is\" => 3, \"Julia\" => 4, \"world\" => 5), nothing)\n\n\n\nCreating a pipe from scratch\n\njulia> tokens = [[1 2; 3 4], [5 6; 7 8]]  # Example word embeddings (each document is a matrix)\n2-element Vector{Matrix{Int64}}:\n [1 2; 3 4]\n [5 6; 7 8]\n\njulia> vocab = Dict(\"hello\" => 1, \"world\" => 2, \"Julia\" => 3)\nDict{String, Int64} with 3 entries:\n  \"hello\" => 1\n  \"Julia\" => 3\n  \"world\" => 2\n\njulia> labels = [\"greeting\", \"statement\"]\n2-element Vector{String}:\n \"greeting\"\n \"statement\"\n\njulia> VectorizedNlpPipe(tokens, vocab, labels)\nVectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[1 2; 3 4], [5 6; 7 8]], Dict(\"hello\" => 1, \"Julia\" => 3, \"world\" => 2), [\"greeting\", \"statement\"])\n\n\n\n\n\n\n\n","category":"type"},{"location":"#Preprocessing_Pipeline_JuML.bag_of_ngrams-Tuple{TokenizedNlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.bag_of_ngrams","text":"bag_of_ngrams(pipe::TokenizedNlpPipe; n::Int = 1) -> VectorizedNlpPipe\n\nCreate a bag of n-grams out of given TokenizedNlpPipe, with padding for shorter documents.\n\nArguments:\n\npipe::TokenizedNlpPipe: The input TokenizedNlpPipe object containing the tokenized documents.\nn::Int: The n-gram size. Defaults to 1.\n\nReturns:\n\nVectorizedNlpPipe: A new VectorizedNlpPipe object with the n-gram vectors.\n\nUsage Example:\n\njulia> NlpPipe([\"words one\", \"words two\"]) |> tokenize |> bag_of_ngrams\nVectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[1 0 0; 0 1 0], [1 0 0; 0 0 1]], Dict(\"two\" => 3, \"one\" => 2, \"words\" => 1), nothing)\n\n\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.bag_of_words-Tuple{TokenizedNlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.bag_of_words","text":"bag_of_words(pipe::TokenizedNlpPipe) -> VectorizedNlpPipe\n\nCreate a bag-of-words-encoding out of given TokenizedNlpPipe\n\nArguments:\n\npipe::TokenizedNlpPipe: The input TokenizedNlpPipe object containing the tokenized documents.\n\nReturns:\n\nVectorizedNlpPipe: A new VectorizedNlpPipe object with the bag-of-words vectors.\n\nExamples:\n\njulia> NlpPipe([\"words one\", \"words two\"]) |> tokenize |> bag_of_words\nVectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[0 1 1], [1 0 1]], Dict(\"two\" => 1, \"one\" => 2, \"words\" => 3), nothing)\n\n\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.create_n_gram_dict-Tuple{TokenizedNlpPipe, Int64}","page":"Home","title":"Preprocessing_Pipeline_JuML.create_n_gram_dict","text":"create_n_gram_dict(pipe, n)\n\nCreate a dictionary of ngrams out of given TokenizedNlpPipe.\n\nExamples:\n\njulia> pipe = TokenizedNlpPipe([[\"one\", \"sentence\", \"sample\"],[\"two\", \"sentence\", \"sample\"]])\njulia> create_n_gram_dict(pipe, 2)\nDict(\"two sentence\" => 2, \"sentence sample\" => 3, \"one sentence\" => 1)\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.expand_contractions-Tuple{NlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.expand_contractions","text":"expand_contractions(input::NlpPipe) -> NlpPipe\n\nExpand contractions in the input text. This function expands common English contractions.\n\nArguments\n\ninput::NlpPipe: A NlpPipe object containing the corpus to expand contractions in.\n\nReturns\n\noutput::NlpPipe: A new NlpPipe object with the contractions expanded in the corpus.\n\nUsage Example\n\njulia> NlpPipe([\"I'm happy\", \"I've got a cat\"]) |> expand_contractions\nNlpPipe([\"I am happy\", \"I have got a cat\"], nothing)\n\n\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.mask_numbers-Tuple{NlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.mask_numbers","text":"mask_numbers(pipe::NlpPipe; replace_with::String=\"<NUM>\") -> NlpPipe\n\nReplaces all numbers in the text of the given NlpPipe corpus with a specified string.\n\nArguments\n\npipe::NlpPipe: The input NlpPipe object containing the corpus to be processed.\nreplace_with::String: The string to replace numbers with. Defaults to \"<NUM>\".\n\nReturns\n\nNlpPipe: A new NlpPipe object with the numbers in the corpus replaced by the specified string.\n\nExample\n\njulia> NlpPipe([\"The price is 1000€.\"]) |> mask_numbers\nNlpPipe([\"The price is <NUM>€.\"], nothing)\n\n\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.one_hot_encoding-Tuple{TokenizedNlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.one_hot_encoding","text":"one_hot_encoding(pipe::TokenizedNlpPipe) -> VectorizedNlpPipe\n\nCreate a one-hot-encoding out of given TokenizedNlpPipe\n\nArguments:\n\npipe::TokenizedNlpPipe: The input TokenizedNlpPipe object containing the tokenized documents.\n\nReturns:\n\nVectorizedNlpPipe: The output VectorizedNlpPipe object containing the one-hot-encoded documents.\n\nExamples:\n\njulia> NlpPipe([\"words one\", \"words two\"]) |> tokenize |> one_hot_encoding\nVectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[0 0 1; 0 1 0], [0 0 1; 1 0 0]], Dict(\"two\" => 1, \"one\" => 2, \"words\" => 3), nothing)\n\n\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.remove_noise-Tuple{NlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.remove_noise","text":"remove_noise(pipe::NlpPipe) -> NlpPipe\n\nRemoves noise from the corpus. Noise includes HTML tags, URLs, email addresses, file paths, special characters, dates & times.\n\nArguments\n\npipe::NlpPipe: The NlpPipe object with a corpus to remove noise from\n\nReturns\n\nA new NlpPipe object with the noise removed from the corpus\n\nUsage Examples\n\njulia> NlpPipe([\"<html>This is a test</html>\"]) |> remove_noise\nNlpPipe([\"This is a test\"], nothing)\n\n\n\nWith custom replacement patterns\n\njulia> NlpPipe([\"<html>This is a test</html>\"]) |> pipe -> remove_noise(pipe, replacement_patterns=[r\"is a\" => \"🦖🫶\"])\nNlpPipe([\"<html>This 🦖🫶 test</html>\"], nothing)\n\n\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.remove_stop_words-Tuple{TokenizedNlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.remove_stop_words","text":"remove_stop_words(pipe::TokenizedNlpPipe; language::String=\"en\", stop_words::Set{String}=Set{String}()) -> TokenizedNlpPipe\n\nRemoves predefined stopwords. You can access the stop words for a given language using the language name or ISO 639 code.  For example, to get the stop words for English, you can use stopwords[\"eng\"], stopwords[\"en\"], or stopwords[\"English\"].\n\nStop words sourced from https://github.com/guo-yong-zhi/StopWords.jl/blob/main/README.md.\n\nParameters\n\npipe: TokenizedNlpPipe\nlanguage: String = \"en\"\nstop_words: Set{String} = Set{String}()\n\nReturns\n\nA new TokenizedNlpPipestruct with the stop words removed from the tokens.\n\nExamples\n\nRemoving stop words from a tokenized pipe (default stop words)\n\njulia> NlpPipe([\"This is a dinosaur\"]) |> tokenize |> remove_stop_words |> pipe -> pipe.tokens\n1-element Vector{Vector{String}}:\n [\"This\", \"dinosaur\"]\n\n\n\nUsing custom stop words\n\njulia> NlpPipe([\"This is a dinosaur\"]) |> tokenize |> pipe -> remove_stop_words(pipe, stop_words=Set([\"This\", \"dinosaur\"])) |> pipe -> pipe.tokens\n1-element Vector{Vector{String}}:\n [\"is\", \"a\"]\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.standardize_document-Tuple{String}","page":"Home","title":"Preprocessing_Pipeline_JuML.standardize_document","text":"standardize_document(doc::String)::String\n\nStandardizes a document by converting it to lowercase and replacing unusual characters with their standard counterparts.\n\nArguments\n\ndoc::String: The input document as a string.\n\nReturns\n\nString: The standardized document as a string.\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.standardize_text-Tuple{NlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.standardize_text","text":"standardize_text(pipe::NlpPipe) -> NlpPipe\n\nApplies the standardize_document function to each document in the corpus of the given NlpPipe object.\n\nArguments\n\npipe::NlpPipe: An NlpPipe object containing a corpus and associated labels.\n\nReturns\n\nNlpPipe: A new NlpPipe object with the standardized corpus and the original labels.\n\nUsage Example\n\njulia> NlpPipe([\"Hello WORLD\", \"Julia is GREAT\"]) |> standardize_text\nNlpPipe([\"hello world\", \"julia is great\"], nothing)\n\n\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.tf_idf-Tuple{TokenizedNlpPipe}","page":"Home","title":"Preprocessing_Pipeline_JuML.tf_idf","text":"tf_idf(pipe::TokenizedNlpPipe; tf_weighting::String = \"relative term frequency\", idf_weighting::String=\"inverse document frequency\") -> VectorizedNlpPipe\n\nCompute the TF-IDF (Term Frequency-Inverse Document Frequency) representation of the tokenized documents in the given pipe.\n\nArguments\n\npipe::TokenizedNlpPipe: A pipeline containing tokenized documents.\ntf_weighting::String: The term frequency weighting scheme. Options are \"relative term frequency\" (default) and \"raw term frequency\".\nidf_weighting::String: The inverse document frequency weighting scheme. Options are \"inverse document frequency\" (default) and \"smooth inverse document frequency\".\n\nReturns\n\nVectorizedNlpPipe: A new pipeline containing the TF-IDF vectorized representation of the documents.\n\nUsage Examples\n\njulia> NlpPipe([\"words one\", \"words two\"]) |> tokenize |> tf_idf\nVectorizedNlpPipe(Matrix{<:Union{Float64, Int64}}[[0.0 0.0 0.0; 0.0 0.35 0.0], [0.0 0.0 0.0; 0.0 0.0 0.35]], Dict(\"two\" => 3, \"one\" => 2, \"words\" => 1), nothing)\n\n\n\n\n\n\n\n","category":"method"},{"location":"#Preprocessing_Pipeline_JuML.tokenize","page":"Home","title":"Preprocessing_Pipeline_JuML.tokenize","text":"tokenize(pipe::NlpPipe, level::Symbol = :word) -> TokenizedNlpPipe\n\nTokenizes the documents in the corpus of the given NlpPipe object. The level parameter can be set to :word or :character.\n\nArguments\n\npipe::NlpPipe: An NlpPipe object containing a corpus of documents.\nlevel::Symbol: The tokenization level, either :word (default) or :character.\n\nReturns\n\nTokenizedNlpPipe: A new TokenizedNlpPipe object with the tokenized documents.\n\nUsage Example\n\njulia> NlpPipe([\"Hello world\", \"Julia is great\"]) |> tokenize\nTokenizedNlpPipe([\"Hello world\", \"Julia is great\"], [[\"Hello\", \"world\"], [\"Julia\", \"is\", \"great\"]], Set([\"great\", \"Hello\", \"is\", \"Julia\", \"world\"]), nothing)\n\n\n\n\n\n\n\n","category":"function"}]
}
