
library(dplyr)
#install.packages("gapminder")
library(gapminder)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# Load the dataset
data("gapminder")

# Selecting Columns
selected_data <- gapminder %>%
  select(country, year, gdpPercap)

print("Selected columns: Country, Year, and GDP per capita")
print(head(selected_data, 10))

# Filtering Rows - 2007 Data for Asia
asia_2007 <- gapminder %>%
  filter(year == 2007, continent == "Asia")

print("GDP per capita data for Asian countries in 2007:")
print(asia_2007)

# Mutating Columns - Creating gdp_million and gdp_growth
mutated_data <- gapminder %>%
  group_by(country) %>%
  mutate(
    gdp_million = gdpPercap * pop / 1e6,
    gdp_growth = ifelse(year == 2007, 
                        (gdpPercap - lag(gdpPercap, 1)) / lag(gdpPercap, 1) * 100, 
                        NA)
  ) %>%
  ungroup()

print("Dataset with new calculated columns:")
print(head(mutated_data, 10))

# Arranging Rows - Sorting by GDP per capita (Descending) and Country (Alphabetically)
sorted_data <- gapminder %>%
  arrange(desc(gdpPercap), country)

# Display the sorted dataset
print("Sorted dataset (Descending GDP per capita, Country):")
print(head(sorted_data, 10))

# Summarizing Data - Compute Average GDP per capita and Total Population
summary_stats <- gapminder %>%
  summarise(
    mean_gdpPercap = mean(gdpPercap, na.rm = TRUE),
    total_pop = sum(pop, na.rm = TRUE)
  )

print("Summary Statistics:")
print(summary_stats)

# Custom Summarization - GDP Rank Function
gdp_rank <- function(gdp_values) {
  rank(-gdp_values, ties.method = "first")
}

ranked_countries <- gapminder %>%
  group_by(year) %>%
  mutate(rank = gdp_rank(gdpPercap)) %>%
  summarise(highest_gdp_country = country[which.min(rank)])

print("Highest-ranked country based on GDP per capita:")
print(ranked_countries)

# Pipe Operator - Continent with Highest Average GDP per capita in 2007
top_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(avg_gdpPercap = mean(gdpPercap, na.rm = TRUE)) %>%
  arrange(desc(avg_gdpPercap)) %>%
  slice(1)

print("Continent with the highest average GDP per capita in 2007:")
print(top_continent_2007)
