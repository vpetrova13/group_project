create_department_table <- function(input, output) {
  
  hospital_data <- eventReactive(input$update,{
    
    department_data %>%
      filter(financial_year == input$year_department) %>% 
      filter(department == input$department) %>%
      slice(1:10)
    
  })
  
  output$department_table_output <- renderTable({
    hospital_data()
  })
}