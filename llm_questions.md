# Question A
think step by step I am making a pipeline for NLP preprocessing and feature extraction. plan is to require the tokenization function before chaining other preprocessing and feature extraction methods. can you think of feature extraction and preprocessing methods that need to come before tokenization?
# Answer A
In an NLP pipeline, the placement of methods before tokenization is rare because tokenization typically acts as the gateway to more granular text processing. However, certain preprocessing steps can or should occur before tokenization, particularly those that work on the raw text. Here's a step-by-step outline with reasoning:
### **Preprocessing Methods Before Tokenization**
1. **Text Standardization**  
   - **Purpose:** Normalize the input text for consistent processing downstream.  
   - **Examples:**
     - Convert encoding (e.g., `UTF-8`) if input text may contain inconsistencies.
     - Replace unusual characters (e.g., non-breaking spaces, dashes) with standard ones.
   - **Implementation Example:** Replace Unicode dashes (`—`) with a hyphen (`-`).
2. **Case Normalization (Optional)**  
   - **Purpose:** Ensure uniform case before tokenization.  
   - **Details:** Some pipelines may choose to convert the text to lowercase upfront. However, this step is more often deferred until after tokenization, depending on the task (e.g., named entity recognition may require original case).
3. **Special Character Removal or Replacement**  
   - **Purpose:** Remove or substitute specific characters that could interfere with tokenization.  
   - **Examples:**
     - Replace multiple spaces with a single space.
     - Remove or standardize line breaks or tabs (`\n` or `\t`).
4. **Contraction Expansion**  
   - **Purpose:** Handle contractions before tokenizing, as splitting contractions after tokenization can be tricky.  
   - **Examples:**
     - Convert `"don't"` → `"do not"`.
     - Convert `"can't"` → `"cannot"`.
5. **Text Cleaning**  
   - **Purpose:** Eliminate noise in the text that is irrelevant to the task.  
   - **Examples:**
     - Remove HTML tags if the input contains raw web text.
     - Remove URLs, email addresses, or file paths.
6. **Language Detection and Filtering**  
   - **Purpose:** Detect the language of the input text and filter out non-target language text.  
   - **Why Before Tokenization?** Language detection algorithms often operate on raw text, not tokens.

7. **Basic Sentence Splitting** (Optional)  
   - **Purpose:** For corpora where sentence boundaries are clear, a preliminary sentence split can aid processing.  
   - **Why Before Tokenization?** Tokenization can be performed sentence-by-sentence later, improving efficiency.

8. **Normalization of Numbers or Dates**  
   - **Purpose:** Replace numeric patterns with placeholders or standardized formats.  
   - **Examples:**
     - Replace `2024-12-11` → `DATE`.
     - Replace `123,456` → `NUM`.
---
### **Preprocessing Methods After Tokenization**
Once tokenization is complete, more specific preprocessing steps can be applied to tokens rather than raw text, such as:
- Removing stop words.
- Lemmatization or stemming.
- Removing punctuation or numeric tokens.
---
### **Pipeline Planning**
Your pipeline can enforce tokenization as the required first step for subsequent methods. Pre-tokenization methods can act as optional steps before entering the pipeline.
#### **Pre-Pipeline Setup**
```plaintext
Raw Text → Preprocessing Steps (Optional) → Tokenization (Required) → Preprocessing/Feature Extraction (Post-Tokenization)
```
#### **Pipeline Example**
1. Input: `"I can't believe it's December 2024. Visit https://example.com!"`
2. Pre-tokenization steps:
   - Normalize text: `"I cannot believe it is December 2024. Visit https://example.com!"`
   - Remove URLs: `"I cannot believe it is December 2024."`
3. Tokenize:
   - Word tokens: `["I", "cannot", "believe", "it", "is", "December", "2024"]`
4. Post-tokenization steps:
   - Remove stop words: `["cannot", "believe", "December", "2024"]`
   - Lemmatization: `["cannot", "believe", "December", "2024"]`
   - Vocabulary extraction, etc.
--- 
This framework ensures a logical and maintainable pipeline for NLP tasks.


# Question B
regex for html tags, urls, file paths, and whatever else ypu can think of to remove in an nlp preprocessing pipeline as npise
# Answer B
Here’s a set of regular expressions (regex) to clean noisy data in an NLP preprocessing pipeline by removing unwanted elements like HTML tags, URLs, file paths, and more.
### 1. **HTML Tags**
To remove tags like `<div>`, `<a href="...">`, etc.:
```regex
<[^>]*>
```

- Matches anything between `<` and `>`.
---
### 2. **URLs**
To remove `http://`, `https://`, or `www.` links:
```regex
https?:\/\/[^\s]+|www\.[^\s]+
```
- Matches URLs starting with `http://` or `https://`.
- Also handles `www.` URLs.
---
### 3. **File Paths**
To remove file paths like `C:\Users\...` or `/usr/bin/...`:
```regex
([A-Za-z]:\\|\/)[^\s]+
```
- Matches Windows paths starting with a drive letter (e.g., `C:\`).
- Matches UNIX-style paths starting with `/`.
---
### 4. **Email Addresses**
To remove email addresses:
```regex
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}
```
- Matches standard email formats like `example@domain.com`.
---
### 5. **Special Characters / Punctuation**
To remove special characters (except for basic punctuation like periods or commas):
```regex
[^a-zA-Z0-9\s.,!?']
```
- Matches anything that isn’t a letter, digit, space, or a few common punctuation marks.
---
### 6. **Numbers**
To remove standalone numbers:
```regex
\b\d+\b
```
- Matches sequences of digits as whole words.
---
### 7. **Excessive Whitespace**
To normalize and remove extra spaces, tabs, and newlines:
```regex
\s+
```
- Matches one or more whitespace characters.
---
### 8. **Markdown Formatting**
To remove formatting like `**bold**`, `_italic_`, or `[link](url)`:
```regex
\*\*[^*]+\*\*|_[^_]+_|`[^`]+`|\[[^\]]+\]\([^\)]+\)
```
- Matches `**bold**`, `_italic_`, inline code `` `code` ``, and markdown links `[text](url)`.
---
### 9. **Twitter Handles / Mentions**
To remove `@username` mentions:
```regex
@\w+
```
---
### 10. **Hashtags**
To remove hashtags like `#NLP`:
```regex
#\w+
```
---
### 11. **Dates and Times**
To remove common date and time formats:
```regex
\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b|\b\d{1,2}:\d{2}(?:AM|PM)?\b
```
- Matches `MM/DD/YYYY`, `DD-MM-YY`, or `HH:MM AM/PM`.
---
### Combining These Patterns
For efficiency, you can combine these regexes into one. Here’s a Python example:
```python
import re

# Combined regex pattern
CLEANING_REGEX = r"""<[^>]*>|                # HTML tags
                     https?:\/\/[^\s]+|     # URLs
                     www\.[^\s]+|          # URLs with www
                     [A-Za-z]:\\[^\s]+|    # Windows file paths
                     \/[^:\s]+|            # UNIX file paths
                     [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}|  # Emails
                     \*\*[^*]+\*\*|_[^_]+_|`[^`]+`|\[[^\]]+\]\([^\)]+\)|  # Markdown
                     @\w+|                 # Mentions
                     #\w+|                 # Hashtags
                     \b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b|  # Dates
                     \b\d{1,2}:\d{2}(?:AM|PM)?\b|        # Times
                     [^a-zA-Z0-9\s.,!?']|  # Special characters
                     \s+"""                # Extra spaces

# Compile and use the regex
cleaning_pattern = re.compile(CLEANING_REGEX, re.VERBOSE)

def clean_text(text):
    return re.sub(cleaning_pattern, " ", text).strip()

# Example text
text = "Hello <b>world</b>! Visit http://example.com or email me at test@example.com. **Markdown** #Hashtag"
print(clean_text(text))
```
### Output Example
Input:
```
Hello <b>world</b>! Visit http://example.com or email me at test@example.com. **Markdown** #Hashtag
```
Output:
```
Hello world! Visit or email me at
```


# Question C
generate a test corpus. multiple sentences. includes text noise. max 7 sentences, max 7 words per sentence.

# Answer C
Here’s a small test corpus with multiple sentences, each containing text noise for testing your NLP preprocessing pipeline:
```plaintext
1. Hello <b>world</b>! Visit http://example.com.
2. Email me: test@example.com or call +123-456-7890.
3. Today is 12/25/2024, time now: 10:30AM.
4. My file is at C:\Users\JohnDoe\Documents\file.txt.
5. Check this out: www.awesome-website.org/about-us.html!
6. #JuliaLang is great. Follow us @JuliaNLP.
7. Special chars: ^&*(@#$)% removed? Let's test!
```
---
### Noise Included:
1. **HTML tags:** `<b>world</b>`
2. **URL:** `http://example.com`, `www.awesome-website.org/about-us.html`
3. **Email:** `test@example.com`
4. **Phone number:** `+123-456-7890`
5. **Date and Time:** `12/25/2024`, `10:30AM`
6. **File path:** `C:\Users\JohnDoe\Documents\file.txt`
7. **Twitter mention:** `@JuliaNLP`
8. **Hashtag:** `#JuliaLang`
9. **Special characters:** `^&*(@#$)%`

# Question D
{
  "a’ight": "alright",
  "ain’t": "am not",
  "amn’t": "am not",
  "’n’ / ‘n’": "and",
  "arencha": "are not you",
  "aren’t": "are not",
  "’bout": "about",
  "can’t": "cannot",
  "cap’n": "captain",
  "’cause": "because",
  "cuz": "because",
  "’cept": "except",
  "c’mon": "come on",
  "could’ve": "could have",
  "couldn’t": "could not",
  "couldn’t’ve": "could not have",
  "cuppa": "cup of",
  "daren’t": "dare not",
  "daresn’t": "dare not",
  "dasn’t": "dare not",
  "didn’t": "did not",
  "doesn't": "does not",
  "don’t": "do not",
  "dunno": "do not know",
  "d’ye": "do you",
  "d’ya": "do you",
  "e’en": "even",
  "e’er": "ever",
  "’em": "them",
  "everybody’s": "everybody has",
  "everyone’s": "everyone has",
  "everything's": "everything has",
  "finna": "fixing to",
  "fo’c’sle": "forecastle",
  "’gainst": "against",
  "g’day": "good day",
  "gimme": "give me",
  "giv’n": "given",
  "gi’z": "give us",
  "gonna": "going to",
  "gon’t": "go not",
  "gotta": "got to",
  "hadn’t": "had not",
  "had’ve": "had have",
  "hasn’t": "has not",
  "haven’t": "have not",
  "he’d": "he had",
  "he'd'nt've": "he did not have",
  "he'll": "he shall",
  "helluva": "hell of a",
  "yesn't": "yes not",
  "he’s": "he has",
  "here’s": "here is",
  "how’d": "how did",
  "howdy": "how do you do",
  "how’ll": "how will",
  "how’re": "how are",
  "how’s": "how has",
  "I’d": "I had",
  "I’d’ve": "I would have",
  "I’d’nt": "I would not",
  "I’d’nt’ve": "I would not have",
  "If’n": "If and when",
  "I’ll": "I shall",
  "I’m": "I am",
  "I’m'onna": "I am going to",
  "Imma": "I am about to",
  "I’m’o": "I am going to",
  "I’m'na": "I am going to",
  "innit": "isn’t it",
  "Ion": "I do not",
  "I’ve": "I have",
  "isn’t": "is not",
  "it’d": "it would",
  "it’ll": "it shall",
  "it’s": "it has",
  "Idunno": "I do not know",
  "kinda": "kind of",
  "lemme": "let me",
  "let’s": "let us",
  "loven’t": "love not",
  "ma’am": "madam",
  "mayn’t": "may not",
  "may’ve": "may have",
  "methinks": "I think",
  "mightn’t": "might not",
  "might’ve": "might have",
  "mine’s": "mine is",
  "mustn’t": "must not",
  "mustn’t’ve": "must not have",
  "must’ve": "must have",
  "’neath": "beneath",
  "needn’t": "need not",
  "nal": "and all",
  "ne’er": "never",
  "no one's": "no one has",
  "o’clock": "of the clock",
  "o’er": "over",
  "ol’": "old",
  "ought’ve": "ought have",
  "oughtn’t": "ought not",
  "oughtn’t’ve": "ought not have",
  "’round": "around",
  "’s": "is",
  "shalln’t": "shall not",
  "shan’": "shall not",
  "shan’t": "shall not",
  "she’d": "she had",
  "she’ll": "she shall",
  "she’s": "she has",
  "she'd'nt've": "she did not have",
  "should’ve": "should have",
  "shouldn’t": "should not",
  "shouldn’t’ve": "should not have",
  "somebody’s": "somebody has",
  "someone’s": "someone has",
  "something’s": "something has",
  "so’re": "so are",
  "so’s": "so is",
  "so’ve": "so have",
  "that’ll": "that shall",
  "that’re": "that are",
  "that’s": "that has",
  "that’d": "that would",
  "there’d": "there had",
  "there’ll": "there shall",
  "there’re": "there are",
  "there’s": "there has",
  "these’re": "these are",
  "these’ve": "these have",
  "they’d": "they had",
  "they’d've": "they would have",
  "they’ll": "they shall",
  "they’re": "they are",
  "they’ve": "they have",
  "this’s": "this has",
  "those’re": "those are",
  "those’ve": "those have",
  "’thout": "without",
  "’til": "until",
  "’tis": "it is",
  "to’ve": "to have",
  "tryna": "trying to",
  "’twas": "it was",
  "’tween": "between",
  "’twere": "it were",
  "w’all": "we all",
  "w’at": "we at",
  "wanna": "want to",
  "wasn’t": "was not",
  "we’d": "we had",
  "we’d’ve": "we would have",
  "we’ll": "we shall",
  "we’re": "we are",
  "we’ve": "we have",
  "weren’t": "were not",
  "whatcha": "what are you",
  "what’d": "what did",
  "what’ll": "what shall",
  "what’re": "what are",
  "what’s": "what has",
  "what’ve": "what have",
  "when’d": "when did",
  "when’s": "when has",
  "where’d": "where did",
  "where’ll": "where shall",
  "where’re": "where are",
  "where’s": "where has",
  "where’ve": "where have",
  "which’d": "which had",
  "which’ll": "which shall",
  "which’re": "which are",
  "which’s": "which has",
  "which’ve": "which have",
  "who’d": "who would",
  "who’d’ve": "who would have",
  "who’ll": "who shall",
  "who’re": "who are",
  "who’s": "who has",
  "who’ve": "who have"
  "why’d": "why did",
  "why'dja": "why did you",
  "why’re": "why are",
  "why’s": "why has",
  "willn’t": "will not",
  "won’t": "will not",
  "wonnot": "will not",
  "would’ve": "would have",
  "wouldn’t": "would not",
  "wouldn’t’ve": "would not have",
  "y’ain’t": "you are not",
  "y’all": "you all",
  "y’all’d’ve": "you all would have",
  "y’all’dn't’ve": "you all would not have",
  "y’all’re": "you all are",
  "y’all’ren’t": "you all are not",
  "y’at": "you at",
  "yes’m": "yes madam",
  "y'ever": "have you ever",
  "y’know": "you know",
  "yessir": "yes sir",
  "you’d": "you had",
  "you’dn’t’ve": "you would not have",
  "you’ll": "you shall",
  "you’re": "you are",
  "you’ve": "you have"
}

turn this into a julia dictionary
# Answer D
Here’s the data converted into a Julia dictionary:

```julia
contractions = Dict(
    "a’ight" => "alright",
    "ain’t" => "am not",
    "amn’t" => "am not",
    "’n’ / ‘n’" => "and",
    "arencha" => "are not you",
    "aren’t" => "are not",
    "’bout" => "about",
    "can’t" => "cannot",
    "cap’n" => "captain",
    "’cause" => "because",
    "cuz" => "because",
    "’cept" => "except",
    "c’mon" => "come on",
    "could’ve" => "could have",
    "couldn’t" => "could not",
    "couldn’t’ve" => "could not have",
    "cuppa" => "cup of",
    "daren’t" => "dare not",
    "daresn’t" => "dare not",
    "dasn’t" => "dare not",
    "didn’t" => "did not",
    "doesn't" => "does not",
    "don’t" => "do not",
    "dunno" => "do not know",
    "d’ye" => "do you",
    "d’ya" => "do you",
    "e’en" => "even",
    "e’er" => "ever",
    "’em" => "them",
    "everybody’s" => "everybody has",
    "everyone’s" => "everyone has",
    "everything's" => "everything has",
    "finna" => "fixing to",
    "fo’c’sle" => "forecastle",
    "’gainst" => "against",
    "g’day" => "good day",
    "gimme" => "give me",
    "giv’n" => "given",
    "gi’z" => "give us",
    "gonna" => "going to",
    "gon’t" => "go not",
    "gotta" => "got to",
    "hadn’t" => "had not",
    "had’ve" => "had have",
    "hasn’t" => "has not",
    "haven’t" => "have not",
    "he’d" => "he had",
    "he'd'nt've" => "he did not have",
    "he'll" => "he shall",
    "helluva" => "hell of a",
    "yesn't" => "yes not",
    "he’s" => "he has",
    "here’s" => "here is",
    "how’d" => "how did",
    "howdy" => "how do you do",
    "how’ll" => "how will",
    "how’re" => "how are",
    "how’s" => "how has",
    "I’d" => "I had",
    "I’d’ve" => "I would have",
    "I’d’nt" => "I would not",
    "I’d’nt’ve" => "I would not have",
    "If’n" => "If and when",
    "I’ll" => "I shall",
    "I’m" => "I am",
    "I’m'onna" => "I am going to",
    "Imma" => "I am about to",
    "I’m’o" => "I am going to",
    "I’m'na" => "I am going to",
    "innit" => "isn’t it",
    "Ion" => "I do not",
    "I’ve" => "I have",
    "isn’t" => "is not",
    "it’d" => "it would",
    "it’ll" => "it shall",
    "it’s" => "it has",
    "Idunno" => "I do not know",
    "kinda" => "kind of",
    "lemme" => "let me",
    "let’s" => "let us",
    "loven’t" => "love not",
    "ma’am" => "madam",
    "mayn’t" => "may not",
    "may’ve" => "may have",
    "methinks" => "I think",
    "mightn’t" => "might not",
    "might’ve" => "might have",
    "mine’s" => "mine is",
    "mustn’t" => "must not",
    "mustn’t’ve" => "must not have",
    "must’ve" => "must have",
    "’neath" => "beneath",
    "needn’t" => "need not",
    "nal" => "and all",
    "ne’er" => "never",
    "no one's" => "no one has",
    "o’clock" => "of the clock",
    "o’er" => "over",
    "ol’" => "old",
    "ought’ve" => "ought have",
    "oughtn’t" => "ought not",
    "oughtn’t’ve" => "ought not have",
    "’round" => "around",
    "’s" => "is",
    "shalln’t" => "shall not",
    "shan’" => "shall not",
    "shan’t" => "shall not",
    "she’d" => "she had",
    "she’ll" => "she shall",
    "she’s" => "she has",
    "she'd'nt've" => "she did not have",
    "should’ve" => "should have",
    "shouldn’t" => "should not",
    "shouldn’t’ve" => "should not have",
    "somebody’s" => "somebody has",
    "someone’s" => "someone has",
    "something’s" => "something has",
    "so’re" => "so are",
    "so’s" => "so is",
    "so’ve" => "so have",
    "that’ll" => "that shall",
    "that’re" => "that are",
    "that’s" => "that has",
    "that’d" => "that would",
    "there’d" => "there had",
    "there’ll" => "there shall",
    "there’re" => "there are",
    "there’s" => "there has",
    "these’re" => "these are",
    "these’ve" => "these have",
    "they’d" => "they had",
    "they’d've" => "they would have",
    "they’ll" => "they shall",
    "they’re" => "they are",
    "they’ve" => "they have",
    "this’s" => "this has",
    "those’re" => "those are",
    "those’ve" => "those have",
    "’thout" => "without",
    "’til" => "until",
    "’tis" => "it is",
    "to’ve" => "to have",
    "tryna" => "trying to",
    "’twas" => "it was",
    "’tween" => "between",
    "’twere" => "it were",
    "w’all" => "we all",
    "w’at" => "we at",
    "wanna" => "want to",
    "wasn’t" => "was not",
    "we’d" => "we had",
    "we’d’ve" => "we would have",
    "we’ll" => "we shall",
    "we’re" => "we are",
    "we’ve" => "we have",
    "weren’t" => "were not",
    "whatcha" => "what are you",
    "what’d" => "what did",
    "what’ll" => "what shall",
    "what’re" => "what are",
    "what’s" => "what has",
    "what’ve" => "what have",
    "when’d" => "when did",
    "when’s" => "when has",
    "where’d" => "where did",
    "where’ll" => "where shall",
    "where’re" => "where are",
    "where’s" => "where has",
    "where’ve" => "where have",
    "which’d" => "which had",
    "which’ll" => "which shall",
    "which’re" => "which are",
    "which’s" => "which has",
    "which’ve" => "which have",
    "who’d" => "who would",
    "who’d’ve" => "who would have",
    "who’ll" => "who shall",
    "who’re" => "who are",
    "who’s" => "who has",
    "who’ve" => "who have",
    "why’d" => "why did",
    "why'dja" => "why did you",
    "why’re" => "why are",
    "why’s" => "why has",
    "willn’t" => "will not",
    "won’t" => "will not",
    "wonnot" => "will not",
    "would’ve" => "would have",
    "wouldn’t" => "would not",
    "wouldn’t’ve" => "would not have",
    "y’ain’t" => "you are not",
    "y’all" => "you all",
    "y’all’d’ve" => "you all would have",
    "y’all’dn't’ve" => "you all would not have",
    "y’all’re" => "you all are",
    "y’all’ren’t" => "you all are not",
    "y’at" => "you at",
    "yes’m" => "yes madam",
    "y'ever" => "have you ever",
    "y’know" => "you know",
    "yessir" => "yes sir",
    "you’d" => "you had",
    "you’dn’t’ve" => "you would not have",
    "you’ll" => "you shall",
    "you’re" => "you are",
    "you’ve" => "you have"
)
```

This creates a Julia `Dict` where each contraction is mapped to its expanded form. Let me know if you need further formatting changes!

# Question E
Is there a regex for finding digits within a string, independent of length?
# Answer E
Yes, there is a regex for finding digits within a string regardless of their length. The pattern is: \d+

Explanation:
- \d matches any single digit (0-9).
- + matches one or more occurrences of the preceding element (in this case, digits).

This means \d+ will match any sequence of consecutive digits in a string, regardless of how long the sequence is."

# Question F
can you list all word contractions that are possible in english language
# Answer F
Here is a comprehensive list of common contractions in English, categorized for easier understanding. While this list may not be exhaustive, it includes nearly all widely used contractions:
### **Contractions with "not"**  
| **Contraction** | **Expansion** |
| --------------- | ------------- |
| aren't          | are not       | 
| can't           | cannot        | 
| couldn't        | could not     |  
| didn't          | did not       |
| doesn't         | does not      |
| don't           | do not        |
| hadn't          | had not       |
| hasn't          | has not       |
| haven't         | have not      |
| isn't           | is not        |
| mightn't        | might not     |
| mustn't         | must not      |
| needn't         | need not      |
| shouldn't       | should not    |
| wasn't          | was not       | 
| weren't         | were not      |
| won't           | will not      |
| wouldn't        | would not     |
### **Contractions with "is/has"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| he's | he is / he has |  
| she's | she is / she has |  
| it's | it is / it has |  
| that's | that is / that has |  
| there's | there is / there has |  
| where's | where is / where has |  
| who's | who is / who has |  
| what's | what is / what has |  
| how's | how is / how has |  
### **Contractions with "will"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| I'll | I will |  
| you'll | you will |  
| he'll | he will |  
| she'll | she will |  
| it'll | it will |  
| we'll | we will |  
| they'll | they will |  
### **Contractions with "would/had"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| I'd | I would / I had |  
| you'd | you would / you had |  
| he'd | he would / he had |  
| she'd | she would / she had |  
| it'd | it would / it had |  
| we'd | we would / we had |  
| they'd | they would / they had |  
### **Contractions with "have"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| I've | I have |  
| you've | you have |  
| we've | we have |  
| they've | they have |  
| who've | who have |  
| would've | would have |  
| could've | could have |  
| should've | should have |  
| might've | might have |  
### **Contractions with "am"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| I'm | I am |  
### **Contractions with "are"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| you're | you are |  
| we're | we are |  
| they're | they are |  
### **Contractions with "let"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| let's | let us |  
### **Contractions with "there"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| there's | there is / there has |  
### **Contractions with "here"**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| here's | here is |  
### **Miscellaneous Contractions**  
| **Contraction** | **Expansion** |  
|---------------|-------------|  
| ain't | am not / is not / are not / has not / have not |  
| o'clock | of the clock |  
| y'all | you all |  
| ma'am | madam |  

This list includes the most commonly used contractions in English. Note that some contractions (like "ain't" or "y'all") are informal or dialectal. Others, like "o'clock", are more specific in usage."

# Question G
is there a regex that can find word contractions like we collected above
# Answer G
Yes, you can use a regex to match English word contractions like those collected above. To do so, the regex should be designed to handle patterns involving an apostrophe (') followed by specific suffixes or entire contracted words.

Here is a general regex that matches the common word contractions listed: 
```
\b(?:[a-zA-Z]+n't|[a-zA-Z]+'(?:ll|re|ve|d|s|m|t))\b"
```

# Question H
how do i set optional keyword arguments in julia in the argument of a function?
# Answer H
In Julia, you can define optional keyword arguments by including them after a semicolon (;) in the function signature. Keyword arguments can have default values, making them optional.

Here’s the general syntax:
```julia
function my_function(positional_arg1, positional_arg2; keyword_arg1=default_value1, keyword_arg2=default_value2)
# Function body
	println("Positional Args: $positional_arg1, $positional_arg2")
	println("Keyword Args: $keyword_arg1, $keyword_arg2")
end
```
  
Key Points:
- Positional Arguments come before the semicolon (;).
- Keyword Arguments are declared after the semicolon and are accessed using name=value when calling the function.
- Keyword arguments can have default values, making them optional.

# Question I
can you provide an example call for stemming for a stemming algorithm in julia please?"
# Answer I
Certainly! Here's an example of how to use a stemming algorithm in Julia with the SnowballStemmer.jl package. I'll show you a typical call for stemming words using this package.

Example: Using Snowball Stemmer for English Text

Install the SnowballStemmer Package (if you haven't done so already):
```julia
using Pkg

Pkg.add("SnowballStemmer")
```
Load the Package and Stem Words:
```julia
using SnowballStemmer
```
##### Create an English stemmer
```julia
stemmer = Stemmer("English")
```
##### Sample input
```julia
words = ["running", "jumps", "happily", "cats"]
```
##### Apply stemming to each word in the vector
```julia
stemmed_words = [stemmer(word) for word in words]
```
##### Display the stemmed words
```julia
println(stemmed_words) # Output: ["run", "jump", "happili", "cat"]
```

Explanation:
- Stemmer("English"): This creates an instance of the English language stemmer.
- stemmer(word): Applies the stemming algorithm to a single word.
- List comprehension [stemmer(word) for word in words]: This applies stemming to each word in the words vector.

Output: The result is a vector of stemmed words, e.g., ["run", "jump", "happili", "cat"].

  

Example Output:
```
["run", "jump", "happili", "cat"]
```
  
- "running" becomes "run".
- "jumps" becomes "jump".
- "happily" becomes "happili" (stemming doesn't always give perfect results for all words).
- "cats" becomes "cat".
- 
Summary:
- Creating the stemmer: `stemmer = Stemmer("English")`.
- Stemming words: Use stemmer(word) for each word.
- Vectorized application: Use list comprehension to stem multiple words.

You can replace "English" with other languages supported by the SnowballStemmer package (like "German", "Spanish", etc.), depending on your needs.

Let me know if you need more examples or adjustments! 😊"

# Question J
what do i call the tag if i replace a number with \<NUM\> in nl
# Answer J
The process of replacing numbers with \<NUM\> in natural language (NL) processing is typically referred to as "number masking" or "number normalization". The tag \<NUM\> itself is often called a placeholder tag, masking token, or entity tag.

Common terminology:
- Number masking: The act of replacing numbers in text with a generic placeholder (e.g., \<NUM\>).
- Placeholder tag: Refers to the specific token used, such as \<NUM\>, \<NUMBER\>, or any other chosen label.
- Normalization: A broader term encompassing various methods of transforming text into a standardized form, including masking numbers.

Would you like help implementing this in a specific scenario?

# Question K
what other masks exist except for \<NUM\>
# Answer K
In Natural Language Processing (NLP), masking involves replacing specific types of tokens with placeholders to generalize or anonymize the text. Apart from \<NUM\>, here are other common masks:

Entity Masks
- \<DATE>: For dates and times (e.g., "January 1, 2025" → \<DATE>).
- \<TIME>: For time expressions (e.g., "3:30 PM" → \<TIME>).
- \<URL>: For URLs or web links (e.g., "https://example.com" → \<URL>).
- \<EMAIL>: For email addresses (e.g., "user@example.com" → \<EMAIL>).
- \<PHONE>: For phone numbers (e.g., "(123) 456-7890" → \<PHONE>).
- \<CURRENCY>: For monetary values (e.g., "$10.50" → \<CURRENCY>).
- \<NAME\>: For proper names (e.g., "John Smith" → \<NAME>).
- \<LOCATION>: For geographic locations (e.g., "New York City" → \<LOCATION>).
- \<ORGANIZATION>: For organizations or companies (e.g., "Google" → \<ORGANIZATION>).
- \<PRODUCT>: For product names (e.g., "iPhone 14" → \<PRODUCT>).

Content-Specific Masks
- \<HASHTAG>: For hashtags in social media (e.g., "#LoveCoding" → \<HASHTAG>).
- \<MENTION>: For social media mentions (e.g., "@user123" → \<MENTION>).
- \<TOKEN>: For general tokens that don't fit into other categories.
- \<SENSITIVE>: For sensitive information like ID numbers, passwords, or personal data.
- \<PLATE>: For license plates or other standardized codes.
- \<FILE>: For file paths or filenames (e.g., "/path/to/file.txt" → \<FILE>).

Custom Masks
Depending on the application, you can create custom masks for domain-specific data:
- \<DISEASE>: For medical terms (e.g., "diabetes" → \<DISEASE>).
- \<SYMPTOM>: For symptoms in clinical text (e.g., "fever" → \<SYMPTOM>).
- \<CHEMICAL>: For chemical names (e.g., "H2SO4" → \<CHEMICAL>).
- \<TAG>: For labels in annotated datasets (e.g., \<POSITIVE> for sentiment analysis).

Miscellaneous
- \<MASK>: A general mask for masked language models like BERT.
- \<UNKNOWN> or \<UNK>: For unknown or out-of-vocabulary tokens.
- \<DIGIT>: If distinguishing single digits from other numbers is important.
- \<AGE>: For age values (e.g., "25 years old" → \<AGE>).

Application-Specific Examples
For legal, medical, or technical fields, masks can be tailored. For example:
- In legal documents: <CASE_NUMBER>, \<LAW_SECTION>.
- In medical records: <PATIENT_ID>, \<DIAGNOSIS>.
- In technical logs: <IP_ADDRESS>, <ERROR_CODE>.

Would you like guidance on implementing a specific set of masks for your use case?


# Question L
create docs like this:
"""

remove_stop_words(pipe::TokenizedNlpPipe; language::String="en", stop_words::Set{String}=Set{String}()) -> TokenizedNlpPipe

Removes predefined stopwords. You can access the stop words for a given language using the language name or ISO 639 code.

For example, to get the stop words for English, you can use stopwords["eng"], stopwords["en"], or stopwords["English"].

Stop words sourced from https://github.com/guo-yong-zhi/StopWords.jl/blob/main/README.md.

###### Parameters
- pipe: TokenizedNlpPipe
- language: String = "en"
- stop_words: Set{String} = Set{String}()
###### Returns
- A new TokenizedNlpPipestruct with the stop words removed from the tokens.
###### Examples
###### Removing stop words from a tokenized pipe (default stop words)
```jldoctest repl

julia> NlpPipe(["This is a dinosaur"]) |> tokenize |> remove_stop_words |> pipe -> pipe.tokens

1-element Vector{Vector{String}}:

["This", "dinosaur"]

---

####### Using custom stop words

jldoctest repl

julia> NlpPipe(["This is a dinosaur"]) |> tokenize |> pipe -> remove_stop_words(pipe, stop_words=Set(["This", "dinosaur"])) |> pipe -> pipe.tokens

1-element Vector{Vector{String}}:

["is", "a"]
```
"""

for this code:

using SnowballStemmer

function stemming(pipe::TokenizedNlpPipe; language::String="english")::TokenizedNlpPipe

\#create stemmer specified language

stemmer = Stemmer(language)

\#do stemming to each word from input

stemmed_data = zeros(Vector{String}, pipe.tokens.length)

for doc in pipe.tokens

stemmed_doc = [stem(stemmer, word) for word in doc]

push!(stemmed_data, stemmed_doc)

end

return TokenizedNlpPipe(pipe.corpus, stemmed_data, pipe.labels)

end

export stemming
# Answer L
Here's a documentation block for the provided stemming function, following the style you specified:

"""
stemming(pipe::TokenizedNlpPipe; language::String="english") -> TokenizedNlpPipe

Applies stemming to the tokens in the provided `TokenizedNlpPipe` based on the specified language.

Stemming reduces words to their base or root form (e.g., "running" to "run"). This function uses the Snowball stemmer library, which supports multiple languages.
###### Parameters
- `pipe`: TokenizedNlpPipe
The input pipeline containing tokenized data.
- `language`: String = "english"
The language to use for stemming. Supported languages depend on the Snowball stemmer library.
###### Returns
- A new `TokenizedNlpPipe` struct with the tokens replaced by their stemmed versions.
###### Examples
###### Applying stemming with the default language (English)
```jldoctest repl

julia> NlpPipe(["This is a test for stemming"]) |> tokenize |> stemming |> pipe -> pipe.tokens

1-element Vector{Vector{String}}:

["this", "is", "a", "test", "for", "stem"]

Specifying a different language for stemming

  

julia> NlpPipe(["Cela teste le stemming"]) |> tokenize |> pipe -> stemming(pipe, language="french") |> pipe -> pipe.tokens

1-element Vector{Vector{String}}:

["cel", "test", "le", "stem"]
```

# Question M
i get this warning with julia

WARNING: Method definition get_vocab_dict(Any) in module Preprocessing_Pipeline_JuML at /home/lad/test/Preprocessing_Pipeline_JuML/src/vectorization/vocabDict.jl:1 overwritten on the same line (check for duplicate calls to include).eline_JuML
# Answer M

This warning means that the method get_vocab_dict is being defined more than once in your Julia code on the same line in the specified file. This often happens when the file containing the method is included multiple times using include.

**Why this happens**
The include function in Julia loads and executes the content of a file. If you call include("file.jl") multiple times in your code, it can lead to method redefinition warnings, as the functions or methods from the file are redefined each time.

**How to fix it**

**Check for duplicate include calls:**
- Ensure that the file vocabDict.jl is included only once in your project. Look for duplicate include statements in your code, such as:
```
include("vectorization/vocabDict.jl")
```
If you find multiple calls, remove the duplicates.

**Use modules properly:**
Wrap your code in vocabDict.jl inside a module. This way, even if the file is included multiple times, the function definitions won't clash.

```
module VocabDict

export get_vocab_dict

function get_vocab_dict(arg)

# Your function definition

end

end

You can then use:

using .VocabDict

get_vocab_dict(arg)
```

**Avoid redundant includes during development:**
If you're including files interactively in a Julia REPL or Jupyter notebook for testing, avoid repeatedly calling include on the same file. Instead, consider using Revise.jl for live-reloading changes:
```
using Revise

include("vectorization/vocabDict.jl")
```

**Clean up project structure:**
Ensure your project is well-structured with a Project.toml file, and place reusable components in dedicated modules or packages. This reduces the need for repeated include calls.

**Verifying the Fix**
After making these changes, restart your Julia session and run the script again. The warning should no longer appear.

# Question N
## Elaborate Example using the SMS-spam-collection Dataset
julia
using MLDatasets: SMSSpamCollection
using Preprocessing_Pipeline_JuML
## Load the SMS spam dataset
data = SMSSpamCollection()

**Step 1: Printing the 5 first samples**

@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide
for feature in data[1:5].features
    println(feature)
end

@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide
println(data[1:5].targets)

**Step 2: Pipelining the Data**
@julia
processed_data = NlpPipe(data.features, data.targets) 
                |> mask_numbers 
                |> remove_noise
                |> standardize_text 
                |> tokenize 
                |> remove_stop_words 
                |> stemming 
                |> bag_of_words

**Step 3: Printing the processed data**

**_Tokens, i.e. The Vectors_**
@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide

processed_data = NlpPipe(data.features, data.targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words #hide

for token in processed_data.tokens[1:5]
    println(token)
end

**_The Vocabulary Dictionary_**
@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide
#small change of calling the function, so that vocabulary is not too long

processed_data = NlpPipe(data[1:5].features, data[1:5].targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words 

println(processed_data.vocabulary)


**_The Labels_**
@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide

processed_data = NlpPipe(data.features, data.targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words #hide

println(processed_data.labels[1:5])

i want to put this code in my docs. but for some reason i get a github action error (not locally) that 
 Error: failed to run @example block in src/example.md:12-20
│ 
@example
│ using MLDatasets: SMSSpamCollection  # hide
│ using Preprocessing_Pipeline_JuML  # hide
│ 
│ data = SMSSpamCollection() #hide
│ for feature in data[1:5].features
│     println(feature)
│ end
│
│   exception =
│    IOError: Could not open stream.
│    Stacktrace:
│      [1] better_readline(stream::Base.PipeEndpoint)
│        @ DataDeps ~/.julia/packages/DataDeps/Y2lje/src/util.jl:57
│      [2] better_readline()
│        @ DataDeps ~/.julia/packages/DataDeps/Y2lje/src/util.jl:55
│      [3] input_choice(::String, ::Char, ::Vararg{Char})
│        @ DataDeps ~/.julia/packages/DataDeps/Y2lje/src/util.jl:82
│      [4] input_bool
│        @ ~/.julia/packages/DataDeps/Y2lje/src/util.jl:70 [inlined]
│      [5] check_if_accept_terms(datadep::DataDeps.DataDep, localpath::String, remotepath::Vector{String})
│        @ DataDeps ~/.julia/packages/DataDeps/Y2lje/src/resolution_automatic.jl:180
│      [6] accept_terms
│        @ ~/.julia/packages/DataDeps/Y2lje/src/resolution_automatic.jl:163 [inlined]
│      [7] download(datadep::DataDeps.DataDep, localdir::String; remotepath::Vector{String}, i_accept_the_terms_of_use::Nothing, skip_checksum::Bool)
│        @ DataDeps ~/.julia/packages/DataDeps/Y2lje/src/resolution_automatic.jl:72
│      [8] download(datadep::DataDeps.DataDep, localdir::String)
│        @ DataDeps ~/.julia/packages/DataDeps/Y2lje/src/resolution_automatic.jl:63
│      [9] handle_missing
│        @ ~/.julia/packages/DataDeps/Y2lje/src/resolution_automatic.jl:10 [inlined]
│     [10] _resolve
│        @ ~/.julia/packages/DataDeps/Y2lje/src/resolution.jl:83 [inlined]
│     [11] resolve(datadep::DataDeps.DataDep, inner_filepath::String, calling_filepath::String)
│        @ DataDeps ~/.julia/packages/DataDeps/Y2lje/src/resolution.jl:29
│     [12] resolve(datadep_name::String, inner_filepath::String, calling_filepath::String)
│        @ DataDeps ~/.julia/packages/DataDeps/Y2lje/src/resolution.jl:54
│     [13] resolve
│        @ ~/.julia/packages/DataDeps/Y2lje/src/resolution.jl:73 [inlined]
│     [14] #13
│        @ ~/.julia/packages/MLDatasets/0MkOE/src/download.jl:14 [inlined]
│     [15] withenv(f::MLDatasets.var"#13#14"{String, Nothing}, keyvals::Pair{String, String})
│        @ Base ./env.jl:257
│     [16] with_accept
│        @ ~/.julia/packages/MLDatasets/0MkOE/src/download.jl:7 [inlined]
│     [17] #datadir#12
│        @ ~/.julia/packages/MLDatasets/0MkOE/src/download.jl:11 [inlined]
│     [18] datadir
│        @ ~/.julia/packages/MLDatasets/0MkOE/src/download.jl:10 [inlined]
│     [19] datafile(depname::String, filename::String, dir::Nothing; recurse::Bool, kw::@Kwargs{})
│        @ MLDatasets ~/.julia/packages/MLDatasets/0MkOE/src/download.jl:30
│     [20] datafile
│        @ ~/.julia/packages/MLDatasets/0MkOE/src/download.jl:29 [inlined]
│     [21] MLDatasets.SMSSpamCollection(; dir::Nothing)
│        @ MLDatasets ~/.julia/packages/MLDatasets/0MkOE/src/datasets/text/smsspamcollection.jl:52
│     [22] MLDatasets.SMSSpamCollection()
│        @ MLDatasets ~/.julia/packages/MLDatasets/0MkOE/src/datasets/text/smsspamcollection.jl:50
│     [23] top-level scope
│        @ example.md:25
│     [24] eval
│        @ ./boot.jl:385 [inlined]
│     [25] #60
│        @ ~/.julia/packages/Documenter/Bs999/src/expander_pipeline.jl:803 [inlined]
│     [26] cd(f::Documenter.var"#60#62"{Module, Expr}, dir::String)
│        @ Base.Filesystem ./file.jl:112
│     [27] (::Documenter.var"#59#61"{Documenter.Page, Module, Expr})()
│        @ Documenter ~/.julia/packages/Documenter/Bs999/src/expander_pipeline.jl:802
│     [28] (::IOCapture.var"#5#9"{DataType, Documenter.var"#59#61"{Documenter.Page, Module, Expr}, IOContext{Base.PipeEndpoint}, IOContext{Base.PipeEndpoint}, Base.PipeEndpoint, Base.PipeEndpoint})()
│        @ IOCapture ~/.julia/packages/IOCapture/Y5rEA/src/IOCapture.jl:170
│     [29] with_logstate(f::Function, logstate::Any)
│        @ Base.CoreLogging ./logging.jl:515
│     [30] with_logger
│        @ ./logging.jl:627 [inlined]
│     [31] capture(f::Documenter.var"#59#61"{Documenter.Page, Module, Expr}; rethrow::Type, color::Bool, passthrough::Bool, capture_buffer::IOBuffer, io_context::Vector{Any})
│        @ IOCapture ~/.julia/packages/IOCapture/Y5rEA/src/IOCapture.jl:167
│     [32] runner(::Type{Documenter.Expanders.ExampleBlocks}, node::MarkdownAST.Node{Nothing}, page::Documenter.Page, doc::Documenter.Document)
│        @ Documenter ~/.julia/packages/Documenter/Bs999/src/expander_pipeline.jl:801
└ @ Documenter ~/.julia/packages/Documenter/Bs999/src/utilities/utilities.jl
# Answer N
The error you’re encountering in your GitHub Actions workflow is likely due to an issue with downloading the SMSSpamCollection dataset in a non-interactive environment. The logs indicate that DataDeps is prompting for user input (to accept terms of use), but in a CI/CD pipeline like GitHub Actions, there is no way to respond interactively.

Possible Solutions

1. Pre-Accept the Terms of Use

Before running your script, explicitly accept the terms of use by setting an environment variable in your GitHub Actions workflow:

env:

  DATADEPS_ALWAYS_ACCEPT: true

Alternatively, you can set this variable at the beginning of your Julia script:

ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"

This will bypass the prompt and allow DataDeps to download the dataset automatically.

2. Manually Download the Dataset in the CI/CD Pipeline

Instead of letting MLDatasets.SMSSpamCollection() handle the download dynamically, manually download the dataset and place it in the appropriate directory:

- name: Manually download SMS Spam Collection dataset

  run: |

    mkdir -p ~/.julia/datadeps/SMSSpamCollection

    wget -O ~/.julia/datadeps/SMSSpamCollection/SMSSpamCollection.txt https://archive.ics.uci.edu/ml/machine-learning-databases/00228/smsspamcollection.zip

This will ensure the dataset is already available before your script runs.

3. Use a Cached Dataset

If your CI/CD workflow allows caching, you can cache the dataset to avoid redownloading it on every run.

- name: Cache MLDatasets

  uses: actions/cache@v3

  with:

    path: ~/.julia/datadeps

    key: ${{ runner.os }}-julia-datadeps

    restore-keys: |

      ${{ runner.os }}-julia-

This caches ~/.julia/datadeps where MLDatasets stores downloaded files.

4. Debug in GitHub Actions

If the issue persists, add a debugging step to inspect the environment in GitHub Actions:

- name: Debug Environment

  run: |

    echo "Home Directory: $HOME"

    ls -la ~/.julia/datadeps

    julia -e 'using Pkg; Pkg.status()'

This will help identify if the dataset is being downloaded correctly.

Recommended Fix

Add the following line to your Julia script:

ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"

If that doesn’t work, implement caching or manual downloading in your GitHub Actions workflow.

Would you like help modifying your .github/workflows/ci.yml file? 🚀