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
alcoholic_map_data <- st_read("data/alcoholic_geographic_data.shp")

# cleaning