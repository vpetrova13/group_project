# Server 
source("R/age_sex_bar_graph.R")
source("R/age_sex_admission.R")
source("R/department_table.R")

server <- function(input, output) {



  
  output$department_table_output <- create_department_table(input = input, output = output)
  

}