# Global
# load in libraries
library(shiny)
library(shinydashboard)
library(tidyverse)
library(dashboardthemes)
library(DT)
library(sf)
# general <- read_csv()

general_age_sex <- read_csv("clean_data/sex_age_clean_data.csv")
alcohol_table <- read_csv("clean_data/clean_alcohol.csv") %>% 
  filter(value_per_one_hundred_thousand_people > 0) 
department_data <- read_csv("clean_data/department_clean_data.csv") %>% 
  filter(stays > 0, average_no_of_nights > 0) 
general_age_sex <- read_csv("clean_data/sex_age_clean_data.csv")

#Map and graph - joining two data
alcohol_clean_data <- read_csv("clean_data/alcohol_clean_for_map_data.csv")
hb_map <- st_read("raw_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp") %>% 
  st_simplify(dTolerance = 2000) %>% 
  select(-Shape_Leng, -Shape_Area)
alcohol_map_data <- full_join(alcohol_clean_data, hb_map, by = c("hb_assign" = "HBCode")) 

#Map for count - joining two data
alcohol_count_data <- read_csv("clean_data/clean_count_map.csv")
alcohol_count_map <- full_join(alcohol_count_data, hb_map, by = c("hb_assign" = "HBCode")) 
