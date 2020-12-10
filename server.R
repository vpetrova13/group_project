# Server 
source("R/age_sex_bar_graph.R")
source("R/age_sex_admission.R")
source("R/alcohol_table.R")
source("R/alcohol_graph.R")
source("R/department_table.R")
source("R/alcoholic_map.R")
source("R/alcohol_specific_plot.R")

server <- function(input, output) {
  
  output$table_output <- createTable(input = input, data = alcohol_table)
  output$histogram <- createGraph(input = input, data = alcohol_table)
  output$age_sex_plot <- create_agesex_bar(input = input, data = general_age_sex)
  output$agesex_admission_plot <- create_agesex_admission(input = input, data = general_age_sex)
  output$department_table_output <- create_department_table(input = input, output = output)
  output$alcoholic_map <- create_alcohol_map(input = input, output = output)
  output$alcoholic_plot <- create_alcohol_plot(input = input, output = output)
}