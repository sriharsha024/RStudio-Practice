library(dplyr)
library(tidyr)
library(ggplot2)
library(corrplot)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# i) Load the Dataset
diabetes_data <- read.csv("C:\\Users\\sagar\\Desktop\\PDSLAB\\diabetes.csv")

# ii) Exploratory Data Analysis
## a) Display first 10 rows
head(diabetes_data, 10)

## b) Summary statistics
summary(diabetes_data)

## c) Structure of the dataset
str(diabetes_data)

# iii) Handling Missing Data
## a) Identify missing values
diabetes_data %>% summarise(across(everything(), ~ sum(is.na(.))))

## b) Replace missing values with median
diabetes_data <- diabetes_data %>%
  mutate(across(everything(), ~ replace(., is.na(.), median(., na.rm = TRUE))))

# iv) Data Visualization
## a) Histogram of Glucose
ggplot(diabetes_data, aes(x = Glucose)) +
  geom_histogram(fill = "blue", bins = 30, color = "black") +
  labs(title = "Distribution of Glucose Levels", x = "Glucose", y = "Count") +
  theme_minimal()

## b) Boxplot of BMI by Outcome
ggplot(diabetes_data, aes(x = as.factor(Outcome), y = BMI, fill = as.factor(Outcome))) +
  geom_boxplot() +
  scale_fill_manual(values = c("red", "green"), labels = c("Non-Diabetic", "Diabetic")) +
  labs(title = "BMI Distribution by Outcome", x = "Outcome", y = "BMI") +
  theme_minimal()

## c) Scatter plot of Insulin vs. Glucose, color-coded by Outcome
ggplot(diabetes_data, aes(x = Glucose, y = Insulin, color = as.factor(Outcome))) +
  geom_point(alpha = 0.7) +
  scale_color_manual(values = c("black", "red"), labels = c("Non-Diabetic", "Diabetic")) +
  labs(title = "Insulin vs Glucose", x = "Glucose", y = "Insulin", color = "Outcome") +
  theme_minimal()

## d) Histogram of Age
ggplot(diabetes_data, aes(x = Age)) +
  geom_histogram(fill = "purple", bins = 30, color = "black") +
  labs(title = "Age Distribution", x = "Age", y = "Count") +
  theme_minimal()

## e) Boxplot of Age by Outcome
ggplot(diabetes_data, aes(x = as.factor(Outcome), y = Age, fill = as.factor(Outcome))) +
  geom_boxplot() +
  scale_fill_manual(values = c("yellow", "blue"), labels = c("Non-Diabetic", "Diabetic")) +
  labs(title = "Age Distribution by Outcome", x = "Outcome", y = "Age") +
  theme_minimal()
# v) Correlation Analysis

## a) Calculate the correlation matrix for numeric variables
cor_matrix <- diabetes_data %>%
  select(where(is.numeric)) %>%
  cor(use = "complete.obs")

## b) Identify the pair of variables with the highest positive correlation
# Set upper triangle to zero to avoid duplicate values
cor_matrix[upper.tri(cor_matrix)] <- 0  

# Find the indices of the highest non-1 correlation value
max_cor_index <- which(cor_matrix == max(cor_matrix[cor_matrix != 1]), arr.ind = TRUE)

# Extract variable names and correlation value
highest_correlation <- tibble(
  Variable1 = rownames(cor_matrix)[max_cor_index[1]],
  Variable2 = colnames(cor_matrix)[max_cor_index[2]],
  Correlation = max(cor_matrix[cor_matrix != 1])
)

# Display the result
print("Highest positive correlation between variables:")
print(highest_correlation)
