create_alcohol_map <- function(input, output) {
  
  plot_map <- eventReactive(input$update_map, {
    
    map_ratio <- alcohol_map_data %>% 
      filter(measurement == "ratio") %>% 
      filter(year == input$year_map) %>% 
      mutate(show_edge = HBName == input$hb) 
    
    map_count <- alcohol_count_map %>% 
      filter(measurement == "count") %>% 
      filter(year == input$year_map) %>% 
      mutate(show_edge = HBName == input$hb)
    
    if (input$ratio_count == "ratio") {
      map_plot <- map_ratio %>% 
      ggplot(aes(fill = value, geometry = geometry, colour = show_edge)) +
      geom_sf() +
      scale_fill_viridis_c(option = "D", trans = "sqrt") + 
      scale_color_manual(values=c("blue4", "yellow"), guide = "none") +
      theme_void() + 
      labs(
        fill = "Stays per 100,000 people"
      )  +
      theme(
        legend.title = element_text(color = "black", size = 15),
        legend.text = element_text(color = "black", size = 10),
        legend.position = "right" 
      ) }
    
    if (input$ratio_count == "count") {
        map_plot <- map_count %>% 
        ggplot(aes(fill = total, geometry = geometry, colour = show_edge)) +
        geom_sf() +
        scale_fill_viridis_c(option = "D", trans = "sqrt") + 
        scale_color_manual(values=c("blue4", "yellow"), guide = "none") +
        theme_void() + 
        labs(
          fill = "Total stays"
        )  +
        theme(
          legend.title = element_text(color = "black", size = 14),
          legend.text = element_text(color = "black", size = 10),
          legend.position = "right"
        ) 
    } 
    map_plot
  })
  output$alcoholic_map <- renderPlot({
    plot_map()
  })
  
}



