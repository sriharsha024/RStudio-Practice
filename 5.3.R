
library(dplyr)
library(ggplot2)  # Contains the diamonds dataset

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# Load the diamonds dataset
data("diamonds")

# 1. Identify the diamond cut with the highest number of diamonds priced above $5000
most_expensive_cut <- diamonds %>%
  filter(price > 5000) %>%
  count(cut, sort = TRUE)  # Count occurrences and sort in descending order

print("Diamond cut with the highest number of diamonds priced above $5000:")
print(most_expensive_cut)

# 2. Find the clarity type with the lightest diamonds (lowest average carat)
lightest_clarity <- diamonds %>%
  group_by(clarity) %>%
  summarise(avg_carat = mean(carat, na.rm = TRUE)) %>%
  arrange(avg_carat)  # Sort by increasing weight

print("Diamond clarity with the lightest diamonds:")
print(lightest_clarity)

# 3. Hypothetical analysis: Monthly price trends (Assuming a sales_date column existed)
# Since the diamonds dataset does not have a date column, this section remains hypothetical.
monthly_avg_price <- diamonds %>%
 mutate(month = format(as.Date(sales_date, "%Y-%m-%d"), "%m")) %>%
 group_by(month) %>%
 summarise(avg_price = mean(price, na.rm = TRUE)) %>%
 arrange(desc(avg_price))

print("Month with the highest average diamond price:")
print(monthly_avg_price)
