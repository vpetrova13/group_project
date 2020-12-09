createTable <- function(input, data){
  
    DT::renderDataTable({
      alcohol_table %>% 
      filter(date_code == input$date_code) %>%
      filter(alcohol_condition == input$alcohol_condition) %>%
      filter(type_of_hospital == input$type_of_hospital)
      
  })
}