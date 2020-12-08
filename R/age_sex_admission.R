create_agesex_admission <- function(input, data) {
  renderPlot({
    data() %>% 
      filter(sex == input$sex) %>% 
      filter(age == input$age) %>% 
      filter(admission_type != "All Inpatients and Daycases", admission_type != "Day case") %>% 
      ggplot() +
      aes(x = financial_year) +
      geom_col(aes(y = average_lengthof_stay_rate, fill = admission_type)) +
      facet_wrap(~admission_type, nrow = 1) +
      theme_classic() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
      labs(
        title = "Scottish average length of stay per 100,000 population",
        x = "Year",
        y = "Number of stays",
        fill = "Admission Type"
      ) + theme(legend.position = "none")
  }
  )
}