# Server 
source("R/age_sex_bar_graph.R")
source("R/age_sex_admission.R")
source("R/department_table.R")

server <- function(input, output) {


  output$age_sex_plot <- create_agesex_bar(input = input, data = general_age_sex)
  output$agesex_admission_plot <- create_agesex_admission(input = input, data = general_age_sex)
  output$department_table_output <- create_department_table(input = input, output = output)
  

}