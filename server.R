# Server 
source("R/age_sex_bar_graph.R")
source("R/age_sex_admission.R")

server <- function(input, output) {
<<<<<<< HEAD

=======
  
  output$distPlot <- create_agesex_bar(input = input, data = general_age_sex)
  
>>>>>>> f12442f743303b0348d5f5a9d20a4a5947487c3c
}