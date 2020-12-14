library(tidyverse)
library(janitor)

alc_raw_data <- read_csv("../raw_data/alcohol_related_hospital_stats.csv") %>% 
  clean_names()

names(alc_raw_data)
glimpse(alc_raw_data)
head(alc_raw_data)


alc_data <- alc_raw_data %>% 
  filter(date_code %in% c("2016/2017","2011/2012","2012/2013", "2010/2011", "2015/2016", "2009/2010", "2014/2015", "2018/2019", "2017/2018", "2013/2014"))  %>% 
  rename(year = date_code) %>% 
  mutate(measurement = str_to_lower(measurement)) %>% 
  mutate(units = str_to_lower(units)) %>% 
  mutate(alcohol_condition = str_to_lower(alcohol_condition)) %>%  
  rename(hospital_activity = alcohol_related_hospital_activity) %>% 
  mutate(hospital_activity = str_to_lower(hospital_activity)) %>% 
  mutate(type_of_hospital = str_to_lower(type_of_hospital)) %>% 
  mutate(year = factor(year, levels = c("2009/2010", "2010/2011", "2011/2012", "2012/2013", "2013/2014", "2014/2015", "2015/2016", "2016/2017", "2017/2018",  "2018/2019")))

alc_data

unique(alc_data$year)

write_csv(alc_data, "alcohol_cleaning_data.csv")