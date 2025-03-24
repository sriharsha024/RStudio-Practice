
library(dplyr)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# Load the mtcars dataset
data("mtcars")

# 1. Car model with the highest horsepower (hp)
most_powerful_car <- mtcars %>% 
  filter(hp == max(hp)) %>% 
  select(hp)

print("Car model with the highest horsepower:")
print(most_powerful_car)

# 2. Car model with the best fuel efficiency (mpg)
best_mpg_car <- mtcars %>% 
  filter(mpg == max(mpg)) %>% 
  select(mpg)

print("Car model with the best fuel efficiency:")
print(best_mpg_car)

# 3. Cylinder category with the highest average weight (wt)
heaviest_cyl_category <- mtcars %>% 
  group_by(cyl) %>% 
  summarise(avg_weight = mean(wt, na.rm = TRUE)) %>% 
  arrange(desc(avg_weight))

print("Cylinder category with the highest average weight:")
print(heaviest_cyl_category)
