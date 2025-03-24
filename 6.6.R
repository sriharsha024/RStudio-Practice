library(ggplot2)

print("K. Sri Harsha Royal")
print("22BCE0893")

# 1. Boxplot: Distribution of MPG by Cylinder Count
ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot() +
  labs(title = "MPG Distribution by Cylinder Count",
       x = "Number of Cylinders",
       y = "Miles per Gallon (MPG)",
       fill = "Cylinders") +
  theme_minimal()

# 2. Scatter Plot: Horsepower vs MPG with Regression Line
ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point(color = "blue", size = 2) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Horsepower vs MPG",
       x = "Horsepower (HP)",
       y = "Miles per Gallon (MPG)") +
  theme_minimal()

# 3. Facet Grid Plot: MPG vs Weight by Gear Type
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(color = "purple", size = 2) +
  facet_grid(. ~ gear) +
  labs(title = "MPG vs Weight for Different Gear Types",
       x = "Weight (1000 lbs)",
       y = "Miles per Gallon (MPG)") +
  theme_minimal()
