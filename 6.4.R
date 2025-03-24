
library(ggplot2)
library(GGally)  # For pairwise plots

print("K. Sri Harsha Royal")
print("22BCE0893")

# 1. Scatter Plot: Sepal.Length vs Sepal.Width with species differentiation
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3) +
  labs(title = "Sepal Length vs Sepal Width",
       x = "Sepal Length (cm)",
       y = "Sepal Width (cm)") +
  theme_minimal()

# 2. Pairwise Plot: Relationships between all numerical variables
ggpairs(iris, aes(color = Species))

# 3. Histogram: Distribution of Petal.Length
ggplot(iris, aes(x = Petal.Length)) +
  geom_histogram(binwidth = 0.5, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Petal Length",
       x = "Petal Length (cm)",
       y = "Count") +
  theme_minimal()
