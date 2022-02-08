## installing packages

install.packages("tidyverse")
install.packages("lubridate")
install.packages("janitor")
install.packages("ggplot2")


library(tidyverse)
library(lubridate)
library(janitor)
library(ggplot2)
library(scales)

## importing the csv data 

td1 <- read_csv("202004-divvy-tripdata.csv")
td2 <- read_csv("202005-divvy-tripdata.csv")
td3 <- read_csv("202006-divvy-tripdata.csv")
td4 <- read_csv("202007-divvy-tripdata.csv")
td5 <- read_csv("202008-divvy-tripdata.csv")
td6 <- read_csv("202009-divvy-tripdata.csv")
td7 <- read_csv("202010-divvy-tripdata.csv")
td8 <- read_csv("202011-divvy-tripdata.csv")
td9 <- read_csv("202012-divvy-tripdata.csv")
td10 <- read_csv("202101-divvy-tripdata.csv")
td11 <- read_csv("202102-divvy-tripdata.csv")
td12 <- read_csv("202103-divvy-tripdata.csv")

## combining all the data frames into one

trip_data <- rbind(td1,td2,td3,td4,td5,td6,td7,td8,td9,td10,td11,td12)

## removing empty rows and columns 

trip_data <-janitor:: remove_empty(trip_data, which = c("rows"))
trip_data <-janitor:: remove_empty(trip_data, which = c("cols"))


## convert date and time data

trip_data$started_at <- lubridate::ymd_hms(trip_data$started_at)
trip_data$ended_at <- lubridate::ymd_hms(trip_data$ended_at)

## parse time in the data frame

#trip_data$start_time <- lubridate::hms(trip_data$started_at)
#trip_data$end_time <- lubridate::hms(trip_data$ended_at)


## creating hour field into the data frame

trip_data$start_hour <- lubridate::hour(trip_data$started_at)
trip_data$end_hour <- lubridate::hour(trip_data$ended_at)

## creating date field into the data frame

trip_data$start_date <- as.Date(trip_data$started_at)
trip_data$end_date <- as.Date(trip_data$ended_at)

#trip_data$start_date <- as.Date(trip_data$started_at)
#trip_data$end_date <- as.Date(trip_data$ended_at)


## calculating trip duration 

#trip_data$trip_duration <- trip_data$ended_at - trip_data$started_at + 1
#trip_data$trip_duration <- difftime(trip_data$started_at, trip_data$ended_at)

## test visualization

trip_data %>% count(start_hour, sort = T) %>% ggplot() + geom_line(aes(x= start_hour, y= n)) +
  scale_y_continuous(labels = comma) + labs(title = "Count of trips by hours: Past 12 months", 
                                            x = "start hours of trips", y = "count of trips")
