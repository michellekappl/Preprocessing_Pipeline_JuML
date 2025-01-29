using MLDatasets: SMSSpamCollection
using Preprocessing_Pipeline_JuML

# Load the SMS spam dataset
data = SMSSpamCollection()

# ----
# printing the first 5 samples
# ----
print(data[1:5].features)
print(data[1:5].targets)

# ----
# pipelining the data
# ----

processed_data = NlpPipe(data.features, data.targets) |> mask_numbers |> remove_noise |> standardize_text |> tokenize |> remove_stop_words |> stemming |> bag_of_words

# ----
# printing the first 5 samples
# ----
print(processed_data.tokens[1:5])
print(processed_data.labels[1:5])