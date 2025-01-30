## Elaborate Example using the SMS-spam-collection Dataset
```julia
using MLDatasets: SMSSpamCollection
using Preprocessing_Pipeline_JuML

# Load the SMS spam dataset
data = SMSSpamCollection()
```

**Step 1: Printing the 5 first samples**

```@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide
for feature in data[1:5].features
    println(feature)
end
```
```@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide
println(data[1:5].targets)
```

**Step 2: Pipelining the Data**

```@julia
processed_data = NlpPipe(data.features, data.targets) 
                |> mask_numbers 
                |> remove_noise 
                |> standardize_text 
                |> tokenize 
                |> remove_stop_words 
                |> stemming 
                |> bag_of_words
```

**Step 3: Printing the processed data**

**_Tokens, i.e. The Vectors_**
```@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide



processed_data = NlpPipe(data.features, data.targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words #hide
for token in processed_data.tokens[1:5]
    println(token)
end
```
**_The Vocabulary Dictionary_**
```@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide


#small change of calling the function, so that vocabulary is not too long
processed_data = NlpPipe(data[1:5].features, data[1:5].targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words 

println(processed_data.vocabulary)
```
**_The Labels_**
```@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide



processed_data = NlpPipe(data.features, data.targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words #hide

println(processed_data.labels[1:5])

```