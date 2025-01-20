# Preprocessing_Pipeline_JuML

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://michellekappl.github.io/Preprocessing_Pipeline_JuML.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://michellekappl.github.io/Preprocessing_Pipeline_JuML.jl/dev/)
[![Coverage](https://codecov.io/gh/micgellekappl/Preprocessing_Pipeline_JuML.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/michellekappl/Preprocessing_Pipeline_JuML.jl)
[![Build Status](https://github.com/michellekappl/Preprocessing_Pipeline_JuML/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/michellekappl/Preprocessing_Pipeline_JuML/actions/workflows/CI.yml?query=branch%3Amain)

**Preprocessing_Pipeline_JuML** is a Julia package for preprocessing text data in NLP pipelines.

## Features
- **Text preprocessing:** prepare textual data for machine learning tasks. Preprocessing steps include:
  - noise removal (punctuation, special characters, phone numbers, e-mail addresses, ...)
  - text standardization (handle encoding & lowercasing)
  - contraction expansion
  - number masking 
  - stop word removal
- **Tokenization:** Split text into words or characters.
- **Vectorization:** Transform text into machine-learning-compatible vector representations (currently only one-hot encoding supported)

## API Structure
The package provides a set of pipeline stages that can be chained together to preprocess text data. The pipeline stages are implemented as functions that take a `NlpPipe` or `TokenizedNlpPipe` struct as input and return a modified object of the same type. This makes it easy to build custom preprocessing pipelines by piping together the desired stages.

### Usage Example:
```julia
corpus = ["Hello, world!", "How are you?"]
pipe = NlpPipe(corpus) |> remove_noise |> tokenize |> one_hot_encoding
# Output: VectorizedNlpPipe with one-hot encoded tokens
```

### Pipe Objects:

**`NlpPipe`** First struct to instantiate in a pipeline. Can be created directly from a text corpus. Can be 
1. used in preprocessing stages that do **not** require the text to be tokenized.
2. transformed into a `TokenizedNlpPipe` by applying the `tokenize` function.

**`TokenizedNlpPipe`** Struct that holds tokenized text data. Can be used for preprocessing stages that require tokenized text (e.g., stopword removal, stemming, etc.). Can be transformed into a `VectorizedNlpPipe` by applying any vectorization function.

**`VectorizedNlpPipe`** Struct that holds vectorized text data (embeddings). Can be used for machine learning tasks.

![Pipeline Diagram](docs/images/pipeline_diagram.png)

# Getting Started
Follow the instructions below to install the package and start using it in your Julia environment.

## Installation in REPL
Clone the repository and include the package in your Julia environment:

```bash
git clone git@github.com:michellekappl/Preprocessing_Pipeline_JuML.git
cd path/to/dir/Preprocessing_Pipeline_JuML
```

Then, activate the package in Julia:

```julia
using Pkg
Pkg.activate(".") 
Pkg.instantiate()
using Preprocessing_Pipeline_JuML
```
This will install the required dependencies and make the package available in your Julia REPL.

## Use The Package
**1. Load the package:**
```julia
using Preprocessing_Pipeline_JuML
```

**2. Prepare a test corpus:**
Define a set of noisy text samples for preprocessing:
```julia
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

```julia
pipe = NlpPipe(test_corpus) |> remove_noise |> tokenize |> one_hot_encoding
```

**4. Inspect the pipeline outputs:**

Get the tokenized representation:

```julia
@info pipe.tokens # contains documents split into single tokens
```

**5. View the vectors and vocabulary generated during vectorization:**

```julia
@info pipe.tokens # contains the tokens from before, but as numeric vectors
@info pipe.vocabulary
```

## Run the tests
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


# **License**

This project is licensed under the MIT License. See the `LICENSE` file for details.

# **Feedback**

If you encounter any issues or have feature requests, please open an issue in the repository. We appreciate your feedback!
