# Load necessary library
library(dplyr)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# i) Create a data frame with the provided table data
students <- data.frame(
  StudentID = c(101, 102, 103, 104, 105),
  Name = c("John", "Jane", "Mike", "Emily", "Anna"),
  Age = c(21, 22, 20, 21, 22),
  Gender = c("M", "F", "M", "F", "F"),
  GPA = c(3.5, 3.8, 2.9, 3.6, 3.9)
)

# ii) Calculate the mean GPA of all students
mean_gpa <- mean(students$GPA)
print(paste("Mean GPA:", mean_gpa))

# iii) Create separate data frames for male and female students
male_students <- filter(students, Gender == "M")
female_students <- filter(students, Gender == "F")

print("Male Students:")
print(male_students)

print("Female Students:")
print(female_students)

# iv) Add a new column named 'Classification' to classify students based on GPA
students <- students %>%
  mutate(Classification = ifelse(GPA >= 3.5, "High", "Low"))

print("Updated Data Frame with Classification:")
print(students)

# v) Identify the student with the highest age and display their Name, Age, and GPA
oldest_student <- students %>%
  filter(Age == max(Age)) %>%
  select(Name, Age, GPA)

print("Oldest Student:")
print(oldest_student)

# vi) Remove duplicate entries based on Name, keeping only the first occurrence
students <- students %>%
  distinct(Name, .keep_all = TRUE)

print("Data Frame after Removing Duplicates:")
print(students)

# vii) Count and display the number of male and female students
gender_count <- students %>%
  group_by(Gender) %>%
  summarise(Count = n())

print("Gender Count:")
print(gender_count)

# viii) Create a summary table that shows the average GPA for each gender
summary_table <- students %>%
  group_by(Gender) %>%
  summarise(Average_GPA = mean(GPA, na.rm = TRUE))

print("Summary Table - Average GPA by Gender:")
print(summary_table)

# Assume some students have missing GPA values
students$GPA[c(2, 4)] <- NA  

# Replace missing GPA values with the median GPA
median_gpa <- median(students$GPA, na.rm = TRUE)
students$GPA[is.na(students$GPA)] <- median_gpa

print("Updated Data Frame with Missing GPAs Replaced by Median:")
print(students)
