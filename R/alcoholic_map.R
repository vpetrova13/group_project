create_alcohol_map <- function(input, output) {
  
  plot_map <- eventReactive(input$update_map, {
    
    alcoholic_map_data %>% 
      filter(year == input$year) %>% 
      mutate(show_edge = HBName == input$hb) %>% 
      filter(measurement == input$ratio_count) %>% 
      ggplot(aes(fill = value, geometry = geometry, colour = show_edge)) +
      geom_sf() +
      scale_fill_viridis_c(option = "D", trans = "sqrt") + 
      scale_color_manual(values=c("blue4", "yellow"), guide = "none") +
      theme_void() + 
      labs(
        fill = "Stays per 100,000 population"
      )  +
      theme(
        legend.title = element_text(color = "black", size = 14),
        legend.text = element_text(color = "black", size = 10),
        legend.position = "right"
      ) 
  
  })
  output$alcoholic_map <- renderPlot({
    plot_map()
  })
  
}



