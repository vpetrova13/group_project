# Global
# load in libraries
library(shiny)
library(shinydashboard)
library(tidyverse)
library(dashboardthemes)
library(DT)
library(sf)
# general <- read_csv()

# 
general_age_sex <- read_csv("data/sex_age_clean_data.csv")
alcohol_table <- read_csv("data/clean_alcohol.csv")
department_data <- read_csv("data/department_clean_data.csv")
general_age_sex <- read_csv("data/sex_age_clean_data.csv")

#Map and graph - joining two data
alcohol_clean_data <- read_csv("data/alcohol_clean_for_map_data.csv")
hb_map <- st_read("data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp") %>% 
  st_simplify(dTolerance = 2000) %>% 
  select(-Shape_Leng, -Shape_Area)
alcohol_map_data <- full_join(alcohol_clean_data, hb_map, by = c("hb_assign" = "HBCode")) 

# cleaning