# Global
# load in libraries
library(shiny)
library(shinydashboard)
library(tidyverse)
library(dashboardthemes)
# general <- read_csv()



department_data <- read_csv("data/department_clean_data.csv")
general_age_sex <- read_csv("data/sex_age_clean_data.csv")

# cleaning