
library(dplyr)
#install.packages("pscl")
library(pscl)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# Load the dataset
data("presidentialElections")

# Selecting Columns
selected_data <- presidentialElections %>%
  select(year, demVote)

print("Selected columns: Year and Democratic Vote Percentage")
print(head(selected_data, 10))

# Filtering Rows - 2008 Election in Colorado
colorado_2008 <- presidentialElections %>%
  filter(year == 2008, state == "Colorado")

print("Election results for Colorado in 2008:")
print(colorado_2008)

# Mutating Columns - Creating other_parties_vote and abs_vote_difference
mutated_data <- presidentialElections %>%
  mutate(
    other_parties_vote = 100 - demVote,
    abs_vote_difference = abs(demVote - other_parties_vote)
  )

print("Dataset with new calculated columns:")
print(head(mutated_data, 10))

# Arranging Rows - Sorting by year (descending) and demVote (ascending)
sorted_data <- presidentialElections %>%
  arrange(desc(year), demVote)

print("Sorted dataset (Descending Year, Ascending Democratic Vote):")
print(head(sorted_data, 10))

# Summarizing Data - Compute Average Democratic and Other Parties' Votes
summary_stats <- presidentialElections %>%
  summarise(
    mean_dem_vote = mean(demVote, na.rm = TRUE),
    mean_other_parties_vote = mean(100 - demVote, na.rm = TRUE)
  )

print("Summary Statistics:")
print(summary_stats)

# Custom Summarization - Function to find the value furthest from 50
furthest_from_50 <- function(votes) {
  votes[which.max(abs(votes - 50))]
}

landslide <- presidentialElections %>%
  summarise(biggest_landslide = furthest_from_50(demVote))

print("Biggest landslide election result:")
print(landslide)

# Pipe Operator - Find the state with the highest Democratic vote in 2008
top_dem_state_2008 <- presidentialElections %>%
  filter(year == 2008) %>%
  arrange(desc(demVote)) %>%
  select(state, demVote) %>%
  slice(1)

print("State with the highest Democratic vote percentage in 2008:")
print(top_dem_state_2008)
