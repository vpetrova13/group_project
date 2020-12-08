create_agesex_bar <- function(input, data) {
  renderPlot({
    data() %>% 
      
    
    }
  )
}


createHisto <- function(input, data){
  renderPlot({
    data() %>% ggplot(aes(x = waiting)) +
      geom_histogram(bins = input$bins, col = "white", fill = "darkred") +
      xlab("Waiting time (mins)") +
      ylab("Number of eruptions") +
      ggtitle("Histogram of eruption waiting times")
  })
}