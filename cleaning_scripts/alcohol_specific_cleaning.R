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
  mutate(year = factor(year, levels = years)) %>% 
  #assign local authorities code to health board 
  mutate(hb_assign = case_when(
    feature_code == "S12000033" ~ "S08000020",
    feature_code == "S12000034" ~ "S08000020",
    feature_code == "S12000041" ~ "S08000030",
    feature_code == "S12000035" ~ "S08000022",
    feature_code == "S12000005" ~ "S08000019",
    feature_code == "S12000006" ~ "S08000017",
    feature_code == "S12000042" ~ "S08000030",
    feature_code == "S12000008" ~ "S08000015",
    feature_code == "S12000045" ~ "S08000031",
    feature_code == "S12000010" ~ "S08000024",
    feature_code == "S12000011" ~ "S08000031",
    feature_code == "S12000036" ~ "S08000024",
    feature_code == "S12000013" ~ "S08000028",
    feature_code == "S12000014" ~ "S08000019",
    feature_code == "S12000047" ~ "S08000029",
    feature_code == "S12000049" ~ "S08000031",
    feature_code == "S12000017" ~ "S08000022",
    feature_code == "S12000018" ~ "S08000031",
    feature_code == "S12000019" ~ "S08000024",
    feature_code == "S12000020" ~ "S08000020",
    feature_code == "S12000021" ~ "S08000015",
    feature_code == "S12000050" ~ "S08000032",
    feature_code == "S12000023" ~ "S08000025",
    feature_code == "S12000048" ~ "S08000030",
    feature_code == "S12000038" ~ "S08000031",
    feature_code == "S12000026" ~ "S08000016",
    feature_code == "S12000027" ~ "S08000026",
    feature_code == "S12000028" ~ "S08000015",
    feature_code == "S12000029" ~ "S08000032",
    feature_code == "S12000030" ~ "S08000019",
    feature_code == "S12000039" ~ "S08000031",
    feature_code == "S12000040" ~ "S08000024")) %>% 
    filter(!is.na(hb_assign))  %>% 
    filter(hospital_activity == "stays") %>%
    filter(alcohol_condition != "all alcohol conditions", alcohol_condition != 
           "all mental & behavioural disorders due to use of alcohol (m&b)",
         alcohol_condition != "all alcoholic liver disease (ald)") %>% 
    mutate(alcohol_condition = str_remove_all(alcohol_condition, "m\\&b\\ \\-\\ ")) %>% 
    mutate(alcohol_condition = str_remove_all(alcohol_condition, "ald\\ \\-\\ ")) %>%
    filter(type_of_hospital == "general acute hospital")

alc_data

unique(alc_data$year)

#Write data for plot
write_csv(alc_data, "alcohol_clean_for_map_data.csv")

#Requires data to show count on map so a new csv file with showing total counts by
#NHS health boards was created. It was done as it does not allow to do calculations
#when plotting the map

count_data <- alc_data %>% 
  filter(measurement == "count") %>% 
  group_by(year, alcohol_condition, hb_assign, measurement) %>% 
  summarise(total = sum(value)) 

write_csv(count_data, "clean_count_map.csv")