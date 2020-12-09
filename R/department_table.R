create_department_table <- function(input, output) {
  
  hospital_data <- eventReactive(input$update,{
    
    department_data %>%
      filter(department == input$department)  %>%
      filter(financial_year == input$year) %>%
      slice(1:10)
    
  })
  
  output$department_table_output <- renderTable({
    hospital_data()
  })
}