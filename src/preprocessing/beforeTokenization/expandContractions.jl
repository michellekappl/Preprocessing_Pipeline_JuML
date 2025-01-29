# Contractions taken from the Wikipedia article on List of English contractions
# (https://en.wikipedia.org/wiki/Wikipedia:List_of_English_contractions)
const contractions = Dict(
    "a'ight" => "alright",
    "ain't" => "am not",
    "amn't" => "am not",
    "'n'" => "and",
    "arencha" => "are not you",
    "aren't" => "are not",
    "'bout" => "about",
    "can't" => "cannot",
    "cap'n" => "captain",
    "'cause" => "because",
    "cuz" => "because",
    "'cept" => "except",
    "c'mon" => "come on",
    "could've" => "could have",
    "couldn't" => "could not",
    "couldn't've" => "could not have",
    "cuppa" => "cup of",
    "daren't" => "dare not",
    "daresn't" => "dare not",
    "dasn't" => "dare not",
    "didn't" => "did not",
    "doesn't" => "does not",
    "don't" => "do not",
    "dunno" => "do not know",
    "d'ye" => "do you",
    "d'ya" => "do you",
    "e'en" => "even",
    "e'er" => "ever",
    "'em" => "them",
    "everybody's" => "everybody is",
    "everyone's" => "everyone is",
    "everything's" => "everything is",
    "finna" => "fixing to",
    "fo'c'sle" => "forecastle",
    "'gainst" => "against",
    "g'day" => "good day",
    "gimme" => "give me",
    "giv'n" => "given",
    "gi'z" => "give us",
    "gonna" => "going to",
    "gon't" => "go not",
    "gotta" => "got to",
    "hadn't" => "had not",
    "had've" => "had have",
    "hasn't" => "has not",
    "haven't" => "have not",
    "he'd" => "he had",
    "he'd'nt've" => "he did not have",
    "he'll" => "he shall",
    "helluva" => "hell of a",
    "yesn't" => "yes not",
    "he's" => "he is",
    "he's got" => "he has got",
    "here's" => "here is",
    "how'd" => "how did",
    "howdy" => "how do you do",
    "how'll" => "how will",
    "how're" => "how are",
    "how's" => "how is",
    "I'd" => "I had",
    "I'd've" => "I would have",
    "I'd'nt" => "I would not",
    "I'd'nt've" => "I would not have",
    "If'n" => "If and when",
    "I'll" => "I shall",
    "I'm" => "I am",
    "I'm'onna" => "I am going to",
    "Imma" => "I am about to",
    "I'm'o" => "I am going to",
    "I'm'na" => "I am going to",
    "innit" => "isn't it",
    "Ion" => "I do not",
    "I've" => "I have",
    "isn't" => "is not",
    "it'd" => "it would",
    "it'll" => "it will",
    "it's" => "it is",
    "Idunno" => "I do not know",
    "kinda" => "kind of",
    "lemme" => "let me",
    "let's" => "let us",
    "loven't" => "love not",
    "ma'am" => "madam",
    "mayn't" => "may not",
    "may've" => "may have",
    "methinks" => "I think",
    "mightn't" => "might not",
    "might've" => "might have",
    "mine's" => "mine is",
    "mustn't" => "must not",
    "mustn't've" => "must not have",
    "must've" => "must have",
    "'neath" => "beneath",
    "needn't" => "need not",
    "nal" => "and all",
    "ne'er" => "never",
    "no one's" => "no one is",
    "o'clock" => "of the clock",
    "o'er" => "over",
    "ol'" => "old",
    "ought've" => "ought have",
    "oughtn't" => "ought not",
    "oughtn't've" => "ought not have",
    "'round" => "around",
    "'s" => "is",
    "shalln't" => "shall not",
    "shan'" => "shall not",
    "shan't" => "shall not",
    "she'd" => "she had",
    "she'll" => "she shall",
    "she's" => "she is",
    "she's got" => "she has got",
    "she'd'nt've" => "she did not have",
    "should've" => "should have",
    "shouldn't" => "should not",
    "shouldn't've" => "should not have",
    "somebody's" => "somebody is",
    "someone's" => "someone is",
    "something's" => "something is",
    "so're" => "so are",
    "so's" => "so is",
    "so've" => "so have",
    "that'll" => "that shall",
    "that're" => "that are",
    "that's" => "that is",
    "that's got" => "that has got",
    "that'd" => "that would",
    "there'd" => "there would",
    "there'll" => "there will",
    "there're" => "there are",
    "there's" => "there is",
    "these're" => "these are",
    "these've" => "these have",
    "they'd" => "they had",
    "they'd've" => "they would have",
    "they'll" => "they will",
    "they're" => "they are",
    "they've" => "they have",
    "this's" => "this is",
    "those're" => "those are",
    "those've" => "those have",
    "'thout" => "without",
    "'til" => "until",
    "'tis" => "it is",
    "to've" => "to have",
    "tryna" => "trying to",
    "'twas" => "it was",
    "'tween" => "between",
    "'twere" => "it were",
    "w'all" => "we all",
    "w'at" => "we at",
    "wanna" => "want to",
    "wasn't" => "was not",
    "we'd" => "we had",
    "we'd've" => "we would have",
    "we'll" => "we will",
    "we're" => "we are",
    "we've" => "we have",
    "weren't" => "were not",
    "whatcha" => "what are you",
    "what'd" => "what did",
    "what'll" => "what will",
    "what're" => "what are",
    "what's" => "what is",
    "what've" => "what have",
    "when'd" => "when did",
    "when's" => "when is",
    "where'd" => "where did",
    "where'll" => "where shall",
    "where're" => "where are",
    "where's" => "where is",
    "where've" => "where have",
    "which'd" => "which had",
    "which'll" => "which shall",
    "which're" => "which are",
    "which's" => "which is",
    "which've" => "which have",
    "who'd" => "who would",
    "who'd've" => "who would have",
    "who'll" => "who shall",
    "who're" => "who are",
    "who's" => "who is",
    "who've" => "who have",
    "why'd" => "why did",
    "why'dja" => "why did you",
    "why're" => "why are",
    "why's" => "why is",
    "willn't" => "will not",
    "won't" => "will not",
    "wonnot" => "will not",
    "would've" => "would have",
    "wouldn't" => "would not",
    "wouldn't've" => "would not have",
    "y'ain't" => "you are not",
    "y'all" => "you all",
    "y'all'd've" => "you all would have",
    "y'all'dn't've" => "you all would not have",
    "y'all're" => "you all are",
    "y'all'ren't" => "you all are not",
    "y'at" => "you at",
    "yes'm" => "yes madam",
    "y'ever" => "have you ever",
    "y'know" => "you know",
    "yessir" => "yes sir",
    "you'd" => "you had",
    "you'dn't've" => "you would not have",
    "you'll" => "you shall",
    "you're" => "you are",
    "you've" => "you have"
)

# Sort the contractions by length (longest ones first) so that, when iterating through them and
# replacing occurrences in a target string, the longer variants of contractions that themselves
# contain another contraction are recognised first.
# E.g., "I'd've" → if "I'd" is replaced first, the "ve" part will be left as is.
sorted_contractions = sort(collect(keys(contractions)), by=length, rev=true)

function expand_contractions_str(input::String)::String
    for contraction in sorted_contractions
        # Regex: \b is a word boundary, so that we don't match substrings within words
        #        i is for case-insensitive matching
        pattern = Regex("\\b" * contraction * "\\b", "i")
        input = replace(input, pattern => contractions[contraction])
    end
    return input
end

"""
    expand_contractions(input::NlpPipe) -> NlpPipe

Expand contractions in the input text. This function expands common English contractions.

# Parameters
- `input::NlpPipe`: A `NlpPipe` object containing the corpus to expand contractions in.

# Returns
- A **new** `NlpPipe` object with the contractions expanded in the corpus.

# Example Usage
```jldoctest repl
julia> NlpPipe(["I'm happy", "I've got a cat"]) |> expand_contractions
NlpPipe(["I am happy", "I have got a cat"], nothing)
```
---
"""
function expand_contractions(pipe::NlpPipe)::NlpPipe
    corpus = map(expand_contractions_str, pipe.corpus)
    return NlpPipe(corpus, pipe.labels)
end