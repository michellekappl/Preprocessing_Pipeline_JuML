```@meta
CurrentModule = Preprocessing_Pipeline_JuML
```

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

![Pipeline Diagram](pipeline_diagram.png)

```@autodocs
Modules = [Preprocessing_Pipeline_JuML]
```
