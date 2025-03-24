
library(dplyr)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# i) Create a data frame with the provided table data
data <- data.frame(
  ID = c(1, 2, 3, 4, 5),
  Name = c("Alice", "Bob", "Carol", "David", "Eve"),
  Age = c(23, 30, 27, 35, 29),
  Gender = c("F", "M", "F", "M", "F"),
  Score = c(85, 90, 78, 88, 91)
)

# ii) Display the first few rows of the data frame
print(head(data))

# iii) Extract and display the Score column from the data frame
print(data$Score)

# iv) Filter and display the rows where the Score is greater than 85
filtered_data <- filter(data, Score > 85)
print(filtered_data)

# v) Add a new column named 'Passed' to the data frame
data <- mutate(data, Passed = Score >= 85)
print(data)

# vi) Calculate and display the summary statistics for the Age and Score columns
summary(data[c("Age", "Score")])

# vii) Update the Name of the row where ID is 2 to "Robert" and display the updated data frame
data <- data %>%
  mutate(Name = ifelse(ID == 2, "Robert", Name))
print(data)

# viii) Sort the data frame by Score in descending order
sorted_data <- data %>% arrange(desc(Score))
print(sorted_data)

# ix) Assume there are missing values in the Score column. Replace missing values with the mean score
data$Score[c(2, 4)] <- NA
mean_score <- mean(data$Score, na.rm = TRUE)
data$Score[is.na(data$Score)] <- mean_score
print(data)

# x) Extract and display the Name and Score columns for rows where Age is less than 30
under_30 <- data %>%
  filter(Age < 30) %>%
  select(Name, Score)
print(under_30)
