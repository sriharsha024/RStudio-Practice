
library(dplyr)
#install.packages("nycflights13")
library(nycflights13)

print("Name: K Sri Harsha Royal")
print("Reg no.: 22BCE0893")

# 1. Identify the Airline with the Highest Number of Delayed Departures
most_delayed_airline <- flights %>%
  filter(dep_delay > 0) %>%  
  group_by(carrier) %>%
  summarise(Delayed_Departures = n()) %>%
  arrange(desc(Delayed_Departures)) %>%
  left_join(airlines, by = "carrier") 

print("Airline with the highest number of delayed departures:")
print(most_delayed_airline[1, ])

# 2. Identify the Destination Airport with the Most Early Arrivals (On Average)
earliest_arrival_airport <- flights %>%
  filter(!is.na(arr_delay)) %>%  
  group_by(dest) %>%
  summarise(Average_Arrival_Delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(Average_Arrival_Delay) %>%
  left_join(airports, by = c("dest" = "faa")) 

print("Destination airport where flights arrive the earliest on average:")
print(earliest_arrival_airport[1, ])

# 3. Identify the Month with the Longest Average Flight Delays
longest_delay_month <- flights %>%
  filter(!is.na(dep_delay)) %>%
  group_by(month) %>%
  summarise(Average_Departure_Delay = mean(dep_delay, na.rm = TRUE)) %>%
  arrange(desc(Average_Departure_Delay))

print("Month with the longest average departure delays:")
print(longest_delay_month[1, ])
