create_alcohol_plot <- function(input, output) {
  
  plot_map_graph <- eventReactive(input$update_map, {
    
  alcohol_map_data %>% 
  filter(year == input$year_map) %>%
  filter(HBName == input$hb) %>% 
  filter(measurement == input$ratio_count) %>%  
  ggplot() +
  aes(x = reorder(alcohol_condition, value),
      y = value,
      fill = alcohol_condition) +
  geom_col() +
  theme_classic() +
  labs(
    title = "Reasons of longest stays",
    x = "Condition",
    y = "Stays per 100,000") +
  theme(legend.position = "none") +
  coord_flip() +
  scale_y_continuous(breaks = c(0,300,600,900,1200,1500,1800,2100,2400,2700,
                                3000, 3300,3600,4100,4400,4700,5000))
    
  })
  
  output$alcoholic_plot <- renderPlot({
    plot_map_graph()
  })
  
}



