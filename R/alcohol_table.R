createTable <- function(input, data){
  
      DT::renderDataTable({
      alcohol_table %>% 
      filter(date_code == input$date_code)
  })
}