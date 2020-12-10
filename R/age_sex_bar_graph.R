create_agesex_bar <- function(input, data) {
  renderPlot({
    general_age_sex %>% 
      filter(admission_type == "All Inpatients and Daycases") %>% 
      filter(sex != "All Sexes") %>% 
      filter(!is.na(age_factor)) %>% 
      mutate(age_factor = factor(age, levels = c("0-4 years", "5-9 years", "10-14 years", "15-19 years", "20-24 years", "25-29 years", "30-34 years", "35-39 years", "40-44 years", "45-49 years",  "50-54 years", "55-59 years", "60-64 years", "65-69 years", "70-74 years","75-79 years", "80-84 years", "85-89 years", "90 years and over"))) %>% 
      filter(financial_year == input$year) %>% 
      ggplot() +
      aes(x = age_factor) +
      geom_col(aes(y = average_lengthof_stay_rate, fill = sex), position = "dodge")  +
      theme_classic() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
      labs(
        title = "Scottish average length of stay per 100,000 population",
        x = "Ages",
        y = "Number of stays",
        fill = "Gender"
      ) +
      scale_y_continuous(breaks = c(0,2,4,6,8,10,12,14,16,18)) +
      theme(text = element_text(size=15))
    }
  )
}


