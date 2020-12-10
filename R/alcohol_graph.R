createGraph <- function(input, data){
  
    renderPlot({
    alcohol_table %>%
      filter(date_code == input$date_code) %>%
      filter(alcohol_condition == input$alcohol_condition) %>%
      filter(type_of_hospital == input$type_of_hospital) %>%
      ggplot() +
      aes(x = reorder(feature_code, value_per_one_hundred_thousand_people),
          y = value_per_one_hundred_thousand_people,
          fill = feature_code) +
      geom_col() +
      coord_flip() +
      theme_classic() +
      labs(
        title = "Condition by Healthboard",
        x = "Healthboard",
        y = "Stays per 100,000 people") +
      theme(legend.position = "none") 
      
    
  })
  
}