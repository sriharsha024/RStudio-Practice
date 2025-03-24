
library(ggplot2)
library(dplyr)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# i) Load the airquality dataset
data("airquality")

# ii) Display the first few rows of the dataset
print(head(airquality))

# iii) Provide summary statistics for the dataset
print(summary(airquality))

# iv) Display the structure of the dataset
print(str(airquality))

# v) Create a basic plot of Ozone levels over time
plot(airquality$Ozone, type = "l", col = "blue", xlab = "Index", ylab = "Ozone Level", main = "Ozone Levels Over Time")

# vi) Handling missing data (Remove rows with missing values)
cleaned_airquality <- na.omit(airquality)

# vii) Display the first few rows of the cleaned dataset
print(head(cleaned_airquality))

# viii) Scatter Plot: Compare Ozone and Temperature
ggplot(cleaned_airquality, aes(x = Temp, y = Ozone)) +
  geom_point(color = "blue") +
  labs(title = "Scatter Plot of Ozone vs Temperature", x = "Temperature (°F)", y = "Ozone Level")

# ix) Add a regression line to the scatter plot to visualize the trend
ggplot(cleaned_airquality, aes(x = Temp, y = Ozone)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Ozone vs Temperature with Regression Line", x = "Temperature (°F)", y = "Ozone Level")

# x) Boxplot: Divide temperature into bins
cleaned_airquality <- cleaned_airquality %>%
  mutate(Temp_Bin = cut(Temp, 
                        breaks = c(-Inf, 59, 69, 79, 89, Inf), 
                        labels = c("Below 60°F", "60-69°F", "70-79°F", "80-89°F", "90°F and above")))

# xi) Create a boxplot of Ozone levels for these temperature bins
ggplot(cleaned_airquality, aes(x = Temp_Bin, y = Ozone, fill = Temp_Bin)) +
  geom_boxplot() +
  labs(title = "Boxplot of Ozone Levels by Temperature Bins", x = "Temperature Bins", y = "Ozone Level") +
  theme(legend.position = "none")

