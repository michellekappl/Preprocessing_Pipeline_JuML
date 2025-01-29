# Installation in REPL

Install the package by running the following commands in Pkg

```pkg
activate --temp
add https://github.com/michellekappl/Preprocessing_Pipeline_JuML
```

This will install the required dependencies and make the package available in your Julia REPL.

# Quickstart
**1. Load the package:**
```julia
using Preprocessing_Pipeline_JuML
```

**2. Prepare a test corpus:**
Define a set of noisy text samples for preprocessing:
```@example
test_corpus = [
   "Hello <b>world</b>! Visit http://example.com.",
   "Email me: test@example.com or call +123-456-7890.",
   "Today is 12/25/2024, time now: 10:30AM.",
   "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.",
   "Check this out: www.awesome-website.org/about-us.html!",
   "#JuliaLang is great. Follow us @JuliaNLP."
]
```

**3. Build your pipeline:**

```@example
test_corpus = [ # hide
   "Hello <b>world</b>! Visit http://example.com.", # hide
   "Email me: test@example.com or call +123-456-7890.", # hide
   "Today is 12/25/2024, time now: 10:30AM.", # hide
   "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.", # hide
   "Check this out: www.awesome-website.org/about-us.html!", # hide
   "#JuliaLang is great. Follow us @JuliaNLP." # hide
] # hide
using Preprocessing_Pipeline_JuML # hide
pipe = NlpPipe(test_corpus) |> remove_noise |> tokenize |> tf_idf
```

**4. View the vectors produced by the pipeline:**

Get the tokenized representation:

```@example
test_corpus = [ # hide
   "Hello <b>world</b>! Visit http://example.com.", # hide
   "Email me: test@example.com or call +123-456-7890.", # hide
   "Today is 12/25/2024, time now: 10:30AM.", # hide
   "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.", # hide
   "Check this out: www.awesome-website.org/about-us.html!", # hide
   "#JuliaLang is great. Follow us @JuliaNLP." # hide
] # hide
using Preprocessing_Pipeline_JuML # hide
pipe = NlpPipe(test_corpus) |> remove_noise |> tokenize |> tf_idf # hide
@info pipe.tokens 
```

**5. View the vocabulary generated during vectorization:**

```@example
test_corpus = [ # hide
   "Hello <b>world</b>! Visit http://example.com.", # hide
   "Email me: test@example.com or call +123-456-7890.", # hide
   "Today is 12/25/2024, time now: 10:30AM.", # hide
   "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.", # hide
   "Check this out: www.awesome-website.org/about-us.html!", # hide
   "#JuliaLang is great. Follow us @JuliaNLP." # hide
] # hide
using Preprocessing_Pipeline_JuML # hide
pipe = NlpPipe(test_corpus) |> remove_noise |> tokenize |> tf_idf # hide
@info pipe.vocabulary
```

**6. (*optional*) View the labels:**
```@example
test_corpus = [ # hide
   "Hello <b>world</b>! Visit http://example.com.", # hide
   "Email me: test@example.com or call +123-456-7890.", # hide
   "Today is 12/25/2024, time now: 10:30AM.", # hide
   "My file is at C:\\Users\\JohnDoe\\Documents\\file.txt.", # hide
   "Check this out: www.awesome-website.org/about-us.html!", # hide
   "#JuliaLang is great. Follow us @JuliaNLP." # hide
] # hide
using Preprocessing_Pipeline_JuML # hide
pipe = NlpPipe(test_corpus) |> remove_noise |> tokenize |> tf_idf # hide
@info pipe.labels
```

# Run the tests
To run the tests, open a Julia REPL, activate the project, and use the `]` key to enter the package management console. Then, execute `test` to run the test suite.
The output should look like this:

```julia repl
(@v1.6) pkg> test
Testing:                    |   52     52  0.6s
  NlpPipe Tests             |   10     10  0.1s
  TokenizedNlpPipe Tests    |    8      8  0.1s
  Remove Stop Words Tests   |    3      3  0.1s
  Expand Contractions Tests |    3      3  0.1s
  Mask Numbers Tests        |    6      6  0.0s
  Remove Noise Tests        |    6      6  0.0s
  Standardize Text Tests    |    2      2  0.0s
  OneHotEncoding Tests      |    2      2  0.1s
  Bag of Words Tests        |    4      4  0.0s
  BagOfNGrams Tests         |    8      8  0.1s
     Testing Preprocessing_Pipeline_JuML tests passed
```