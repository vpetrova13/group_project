library(tidyverse)
library(janitor)

# Source ----
source("cleaning_scripts/config.R")

alc_raw_data <- read_csv("raw_data/alcohol_related_hospital_statistics.csv") %>% 
  clean_names()

names(alc_raw_data)
glimpse(alc_raw_data)
head(alc_raw_data)

#Filter years and lower observations
alc_data <- alc_raw_data %>% 
  filter(date_code %in% years)  %>% 
  rename(year = date_code) %>% 
  mutate(measurement = str_to_lower(measurement)) %>% 
  mutate(units = str_to_lower(units)) %>% 
  mutate(alcohol_condition = str_to_lower(alcohol_condition)) %>%  
  rename(hospital_activity = alcohol_related_hospital_activity) %>% 
  mutate(hospital_activity = str_to_lower(hospital_activity)) %>% 
  mutate(type_of_hospital = str_to_lower(type_of_hospital)) %>% 
  mutate(year = factor(year, levels = years))

alc_data

unique(alc_data$year)

write_csv(alc_data, "alcohol_cleaning_data.csv")