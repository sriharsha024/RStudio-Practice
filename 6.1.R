library(httr)
library(jsonlite)
library(ggplot2)
library(dplyr)
library(lubridate)
library(scales)

print("K. Sri Harsha Royal")
print("22BCE0893")

# Set API Key
api_key <- "your_api_key"  

city <- "London"

# 1. Current Weather Data 

base_url <- "http://api.openweathermap.org/data/2.5/weather"
response <- GET(url = base_url, query = list(q = city, appid = api_key, units = "metric"))
weather_data <- fromJSON(content(response, "text", encoding = "UTF-8"))
if (weather_data$cod != 200) {
  print(paste("Error:", weather_data$message))
} else {
  print(paste("City:", weather_data$name))
  print(paste("Temperature:", weather_data$main$temp, "°C"))
  print(paste("Weather:", weather_data$weather$description[1]))
  print(paste("Humidity:", weather_data$main$humidity, "%"))
}


# 2. 5-Day Forecast & Plot

forecast_url <- "http://api.openweathermap.org/data/2.5/forecast"
forecast_response <- GET(url = forecast_url, query = list(q = city, appid = api_key, units = "metric"))
forecast_data <- fromJSON(content(forecast_response, "text", encoding = "UTF-8"))

forecast_df <- data.frame(
  date = as.Date(forecast_data$list$dt_txt),
  temp = forecast_data$list$main$temp
)

# Compute daily averages
daily_avg_temp <- forecast_df %>%
  group_by(date) %>%
  summarise(avg_temp = mean(temp))

# Plot the forecast data
ggplot(daily_avg_temp, aes(x = date, y = avg_temp)) +
  geom_line(color = "blue") +
  geom_point() +
  labs(title = paste("5-Day Temperature Forecast for", city),
       x = "Date", y = "Average Temperature (°C)") +
  theme_minimal()

# 3. 5-Day Historical Data Retrieval & Dual Axis Plot

historical_url <- "http://api.openweathermap.org/data/2.5/onecall/timemachine"
lat <- 51.51   # London's latitude
lon <- -0.13   # London's longitude

# OpenWeatherMap's free-tier API allows fetching historical weather only for the last 5 days
dates <- seq(Sys.Date() - 5, Sys.Date() - 1, by = "days")
historical_df <- data.frame(date = character(), temp = numeric(), humidity = numeric())
for (d in dates) {
  timestamp <- as.numeric(as.POSIXct(d, tz = "UTC"))
  response <- GET(historical_url, query = list(
    lat = lat, lon = lon, dt = timestamp, appid = api_key, units = "metric"
  ))
  
  if (http_status(response)$category != "Success") {
    print(paste("API error on", d, ":", http_status(response)$message))
    next
  }
  
  data <- fromJSON(content(response, "text", encoding = "UTF-8"))
  
  if (!is.null(data$current) && !is.null(data$current$temp) && !is.null(data$current$humidity)) {
    historical_df <- rbind(historical_df, data.frame(
      date = as.character(d),
      temp = data$current$temp,
      humidity = data$current$humidity
    ))
  } else {
    print(paste("No valid data for", d))
  }
}

# Ensure we don't use max() on an empty dataframe
if (nrow(historical_df) > 1) {
  max_temp <- max(historical_df$temp, na.rm = TRUE)
  
  ggplot(historical_df, aes(x = as.Date(date))) +
    geom_line(aes(y = temp, color = "Temperature (°C)")) +
    geom_line(aes(y = humidity / 100 * max_temp, color = "Humidity (%)")) +
    scale_y_continuous(sec.axis = sec_axis(~ . / max_temp * 100, name = "Humidity (%)")) +
    labs(title = paste("Historical Weather Data for", city),
         x = "Date", y = "Temperature (°C)") +
    theme_minimal()
} else {
  print("No valid historical data retrieved.")
}
