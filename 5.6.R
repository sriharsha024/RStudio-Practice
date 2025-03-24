
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(ggrepel)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# Load data 
wb_data <- read.csv("C:\\Users\\sagar\\Desktop\\PDSLAB\\world_bank_data.csv", 
                    stringsAsFactors = FALSE, skip = 4)

# 1. Compare Each Country's Educational Expenditure in 1990 and 2014
indicator <- "Government expenditure on education, total (% of GDP)"
expenditure_plot_data <- wb_data %>%  
  filter(Indicator.Name == indicator) %>%
  select(Country.Code, X1990, X2014) %>%
  drop_na()

expenditure_chart <- ggplot(data = expenditure_plot_data) +
  geom_text_repel(aes(x = X1990 / 100, y = X2014 / 100, label = Country.Code)) +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(title = indicator, x = "Expenditure in 1990", y = "Expenditure in 2014") +
  theme_minimal()

print(expenditure_chart)

# 2. Reshape Educational Data for Spain
long_year_data <- wb_data %>%
  pivot_longer(cols = starts_with("X"), names_to = "year", values_to = "value")

indicator <- "Government expenditure on education, total (% of GDP)"
spain_plot_data <- long_year_data %>%
  filter(Indicator.Name == indicator, Country.Code == "ESP") %>%
  mutate(year = as.numeric(substr(year, 2, 5))) # Remove "X" before each year

# Visualize Spain's expenditure over time
chart_title <- paste(indicator, "in Spain")
spain_chart <- ggplot(data = spain_plot_data) +  
  geom_line(aes(x = year, y = value / 100), color = "blue") +  
  scale_y_continuous(labels = percent_format(accuracy = 1)) +  
  labs(title = chart_title, x = "Year", y = "Percent of GDP Expenditure") +
  theme_minimal()

print(spain_chart)

# 3. Compare Female Literacy Rate and Female Unemployment Rate

# Reshape data to wide format
wide_data <- long_year_data %>%
  select(-Indicator.Code) %>%
  pivot_wider(names_from = Indicator.Name, values_from = value)

# Define variable names
x_var <- "Literacy rate, adult female (% of females ages 15 and above)"
y_var <- "Unemployment, female (% of female labor force) (modeled ILO estimate)"

# Filter for the year 2014 and prepare data for plotting
lit_plot_data <- wide_data %>%
  mutate(year = as.numeric(sub("X", "", year))) %>%  # Remove 'X' and convert to numeric
  filter(year == 2014) %>%
  transmute(
    Country = Country.Name,  # Keep country names for labeling
    Literacy_Rate = .[[x_var]] / 100,  
    Unemployment_Rate = .[[y_var]] / 100
  ) %>%
  drop_na()

# Create scatter plot
ggplot(lit_plot_data, aes(x = Literacy_Rate, y = Unemployment_Rate)) +  
  geom_point(color = "red") +  
  geom_text_repel(aes(label = Country), size = 3) +  # Add country labels for better readability
  scale_x_continuous(labels = percent_format(accuracy = 1)) +  
  scale_y_continuous(labels = percent_format(accuracy = 1)) +  
  labs(
    x = "Female Literacy Rate (% of females 15+)", 
    y = "Female Unemployment Rate (% of labor force)", 
    title = "Female Literacy Rate vs Female Unemployment Rate (2014)"
  ) +
  theme_minimal()
