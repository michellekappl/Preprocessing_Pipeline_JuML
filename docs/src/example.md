## Elaborate example with SMS-spam-collection dataset
```julia
using MLDatasets: SMSSpamCollection
using Preprocessing_Pipeline_JuML

# Load the SMS spam dataset
data = SMSSpamCollection()
```

### Printing the first 5 samples

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

### Pipelining the data

```@julia

processed_data = NlpPipe(data.features, data.targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |> bag_of_words
```

### Printing the first 5 samples


### Tokens, i.e. the vectors
```@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide



processed_data = NlpPipe(data.features, data.targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words #hide
for token in processed_data.tokens[1:5]
    println(token)
end
```
### The vocabulary dictionary
```@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide


#small change of calling the function, so that vocabulary is not too long
processed_data = NlpPipe(data[1:5].features, data[1:5].targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words 

println(processed_data.vocabulary)
```
### The labels
```@example
using MLDatasets: SMSSpamCollection  # hide
using Preprocessing_Pipeline_JuML  # hide

data = SMSSpamCollection() #hide



processed_data = NlpPipe(data.features, data.targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |>bag_of_words #hide

println(processed_data.labels[1:5])

```