# Server 
source("R/age_sex_bar_graph.R")
source("R/age_sex_admission.R")

server <- function(input, output) {
  
  output$distPlot <- create_agesex_bar(input = input, data = general_age_sex)
  
}