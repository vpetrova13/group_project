# UI 
ui <- dashboardPage(
  dashboardHeader(
    title = h3("Health Scotland")
   
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("align-justify")),
      menuItem("Map", tabName = "map", icon = icon("stop")),
      menuItem("Regional Overview", tabName = "regional", icon = icon("signal"))
    )
  ),
  dashboardBody(
    # Changing theme <- this needs to go inside the dashboardBody
    shinyDashboardThemes(
      theme = "purple_gradient"
    ),
    tabItems(
      # First tab content <- general overview
      tabItem(
        tabName = "overview",
        h2("Overview of hospital admissions in Scotland"),
        fluidRow(
          box(
            width = 12,
            h4("About"),
            h6("This is a dashboard that visualises the annual quantity of patients received
               each year by hospitals in Scotland."),
            h6("For this overview tab, the data has been broken down by age and sex for patient daycase 
               activity in the 14 scottish healthboards."),
            h6("Source of dataset for this tab:",
               tags$a("Public Health Scotland Website",
                      href = "https://www.opendata.nhs.scot/dataset/annual-inpatient-and-daycase-activity"))
            
          )
        ),
        fluidRow(
          box(
            width = 3,
            selectInput("year", label = h4("Select Year"), 
                        choices = unique(general_age_sex$financial_year), 
                        selected = "2019/20")
          ),
          
          box(
            width = 9,
            plotOutput("age_sex_plot")
          )
        ),
        
        fluidRow(
          box(
            width = 3, 
            radioButtons("sex", label = h4("Select Gender"),
                         choices = list("Female" = "Female", "Male" = "Male", 
                                        "All" = "All Sexes"), 
                         selected = "All Sexes"),
            selectInput("age", label = h4("Select Age Group"), 
                        choices = unique(general_age_sex$age), 
                        selected = "All Ages")
          ),
          
          box(
            width = 9, 
            plotOutput("agesex_admission_plot")
          )
        ),
        
        fluidRow(
          box(

            width = 3,

            
            #####
            selectInput("year",
                        label = h4("Select Year"),
                        choices = unique(department_data$financial_year)),
            
            selectInput("department",
                        label = h4("Select Department"),
                        choices = unique(department_data$department)),
            
            actionButton("update", "Thank you NHS")
            #####
          ),
          
          box(
            width = 9,
            
            tableOutput("department_table_output")
          )
        )
      ),
      # Second tab content <- map and graph
      tabItem(
        tabName = "map",
        h2("Spatial data"),
        
        fluidRow(
          box(
            width = 12,
            h3("About"),
            h6("This map and graph show the count and ratio (per 100,000 people) of
               some of the most common conditions caused by abuse of alcohol throughout Scotland."),
            h6("Source of dataset for this tab:",
               tags$a("Scottish Government Website",
                      href = "https://statistics.gov.scot/resource?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2Falcohol-related-hospital-statistics"))
            
          )
        ),
        
        fluidRow(
          
          column(width = 3,
            box(
              width = NULL,
              selectInput("year_map", label = h4("Select Year"), 
                          choices = unique(alcohol_map_data$year), 
                          selected = "2018/2019")
            ),
            box(
              width = NULL,
              selectInput("hb", label = h4("Select Health Board"), 
                          choices = unique(alcohol_map_data$HBName),
                          selected = "Lothian")
            ),
            box(
              width = NULL, 
              radioButtons("ratio_count", label = h4("Select Ratio or Count"),
                           choices = list("Ratio" = "ratio", "Count" = "count"),
                           selected = "ratio")

            ),
            box(
              width = NULL,
              actionButton("update_map", "Show map & graph")
            )
          ),
          
          column(width = 9,
            box(
              width = NULL, 
              plotOutput("alcoholic_map")
            ),
            box(
              width = NULL,
              plotOutput("alcoholic_plot")
            )
          )
        )
      ),
      # Third tab content <- table and graph
      tabItem(
        tabName = "regional",
        h2("Hospital admissions related to alcohol by healthboard"),
        
        fluidRow(
          box(
            width = 12,
            h3("About"),
            h6("The graph and table on this tab show a comparison of summarised groups of medical conditions 
            caused by the abuse of alcohol. Comparisons can be drawn based on NHS healthboards."),
            h6("Source of dataset for this tab:",
               tags$a("Scottish Government Website",
                      href = "https://statistics.gov.scot/resource?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2Falcohol-related-hospital-statistics"))
          )
        ),
        
        fluidRow(
          
          column(width = 3,
                 box(
                   width = NULL,
                   selectInput("date_code",
                              label = h4("Select Year"), 
                              choices = unique(alcohol_table$date_code)
                   )
                 ),
                 box(
                   width = NULL,
                   radioButtons("alcohol_condition",
                                label = h4("Select Condition"),
                                choices = unique(alcohol_table$alcohol_condition)
                   )
                 ),
                 box(
                   width = NULL,
                   radioButtons("type_of_hospital",
                                label = h4("Select type of hospital"),
                                choices = unique(alcohol_table$type_of_hospital)
                   )
                 )
                 
          ),
          
          column(width = 9,
                 box(
                   width = NULL,
                   plotOutput("histogram")
                 ),
                 box(
                   width = NULL,
                   div(style = 'overflow-x: scroll',
                   DT::dataTableOutput("table_output")),
                   status = "primary"
                 )
          )
        )
      )
    )
  )
)