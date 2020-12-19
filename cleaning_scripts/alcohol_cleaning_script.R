# Load in libraries
library(tidyverse)
library(janitor)

# Source ----
source("cleaning_scripts/config.R")

# alcohol cleaning script ---------------------------------------------------
alcohol <- read_csv("raw_data/alcohol_related_hospital_statistics.csv")

# clean column names
clean_names_alcohol <- clean_names(alcohol)

# date group 2010-2019
# grouping by health board and Scotland feature_codes 
clean_alcohol <- clean_names_alcohol %>%
  filter(date_code %in% c("2010/2011", "2011/2012", "2012/2013", "2013/2014", 
                          "2014/2015", "2015/2016", "2016/2017", "2017/2018", 
                          "2018/2019")) %>%
  filter(feature_code %in% c("S08000020", "S08000030", "S08000022", "S08000019",
                             "S08000017", "S08000015", "S08000031", "S08000024", 
                             "S08000028", "S08000029", "S08000032", "S08000025",
                             "S08000016", "S08000026")) %>%
  filter(measurement == "Ratio") %>%
  filter(type_of_hospital != "All") %>%
  filter(alcohol_related_hospital_activity == "Stays") %>%
  filter(alcohol_condition %in% c("All Alcoholic Liver Disease (ALD)",
                                  "All mental & behavioural disorders due to use of alcohol (M&B)",
                                  "All alcohol conditions")) %>%
  mutate(feature_code = recode(feature_code,
                               "S08000015" = "NHS Ayrshire and Arran",
                               "S08000016" = "NHS Borders",
                               "S08000017" = "NHS Dumfries and Galloway",
                               "S08000019" = "NHS Forth Valley",
                               "S08000020" = "NHS Grampian",
                               "S08000022" = "NHS Highland",
                               "S08000024" = "NHS Lothian",
                               "S08000025" = "NHS Orkney",
                               "S08000026" = "NHS Shetland",
                               "S08000028" = "NHS Western Isles",
                               "S08000029" = "NHS Fife",
                               "S08000030" = "NHS Tayside",
                               "S08000031" = "NHS Greater Glasgow and Clyde",
                               "S08000032" = "NHS Lanarkshire")) %>%
  mutate(alcohol_condition = recode(alcohol_condition,
                                    "All Alcoholic Liver Disease (ALD)" = "Alcoholic Liver Disease",
                                    "All mental & behavioural disorders due to use of alcohol (M&B)" = "Mental and Behavioural Disorders",
                                    "All alcohol conditions" = "All other Alcoholic Conditions")) %>%
  select(-measurement, -units, -alcohol_related_hospital_activity) %>%
  rename(value_per_one_hundred_thousand_people = value)


write_csv(clean_alcohol, "clean_data/clean_alcohol.csv")