
library(ggplot2)
library(dplyr)

print("K. Sri Harsha Royal")
print("22BCE0893")

# 1. Line Plot: Average Temperature Over Time
ggplot(airquality, aes(x = Day, y = Temp, group = Month, color = factor(Month))) +
  geom_line(size = 1) +
  labs(title = "Daily Temperature Trends",
       x = "Day of the Month",
       y = "Temperature (°F)",
       color = "Month") +
  theme_minimal()

# 2. Bar Plot: Average Ozone Levels per Month
airquality %>%
  group_by(Month) %>%
  summarise(Average_Ozone = mean(Ozone, na.rm = TRUE)) %>%
  ggplot(aes(x = factor(Month), y = Average_Ozone, fill = factor(Month))) +
  geom_bar(stat = "identity") +
  labs(title = "Average Ozone Levels by Month",
       x = "Month",
       y = "Average Ozone (ppb)",
       fill = "Month") +
  theme_minimal()

# 3. Boxplot: Wind Speed Across Different Months
ggplot(airquality, aes(x = factor(Month), y = Wind, fill = factor(Month))) +
  geom_boxplot() +
  labs(title = "Wind Speed Distribution by Month",
       x = "Month",
       y = "Wind Speed (mph)",
       fill = "Month") +
  theme_minimal()
