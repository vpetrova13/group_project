
library(tidyverse)
library(janitor)

# Source ----
source("cleaning_scripts/config.R")
#reading csv 

specialty <- read_csv("raw_data/activity_specialty.csv") %>% 
  clean_names()


#filtering health board code to the whole of Scotland rather than individual areas

department <- specialty %>% 
  select(financial_year, admission_type, hb, specialty_name, stays, average_lengthof_stay_rate) %>% 
  filter(hb == scotland_hb)

#filtering on admission type

department_clean <- department %>% 
  select(-hb) %>% 
  filter(admission_type == "All Inpatients")

#renaming columns

by_department <- department_clean %>% 
  rename(department = specialty_name) %>% 
  rename(average_no_of_nights = average_lengthof_stay_rate)

#write csv

write_csv(by_department, "department_clean_data.csv")

