library(tidyverse)
library(janitor)

# Source ----
source("cleaning_scripts/config.R")

#Filter Scotland data (HB = SB92000003)
sex_age_raw <- read_csv("../raw_data/activity_age_sex.csv") %>% filter(HB == scotland_hb)
deprivaton_raw <- read_csv("../raw_data/activity_deprivation.csv") %>% filter(HB == scotland_hb)
specialty_raw <- read_csv("../raw_data/activity_specialty.csv") %>% filter(HB == scotland_hb)

names(sex_age_raw)

#Select necessary columns for further analysis
sex_age_data <- sex_age_raw %>% 
  select(1, FinancialYear, AdmissionType, HB, Age, Sex, Episodes, Stays, TotalLengthofEpisode, TotalLengthofStay, AverageLengthofEpisodeRate, AverageLengthofStayRate, Patients) %>% 
  clean_names() %>% 
  mutate(age_factor = factor(age, levels = c("0-4 years", "5-9 years", "10-14 years", "15-19 years", "20-24 years", "25-29 years", "30-34 years", "35-39 years", "40-44 years", "45-49 years",  "50-54 years", "55-59 years", "60-64 years", "65-69 years", "70-74 years","75-79 years", "80-84 years", "85-89 years", "90 years and over")))

sex_age_data

unique(sex_age_data$age_factor)

write_csv(sex_age_data, "sex_age_clean_data.csv")