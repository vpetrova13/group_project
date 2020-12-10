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
            width = 6,
            h4("About"),
            h6("This is a dashboard that visualises the annual quanitity of pantients recieved each year by
               hospitals in scotland"),
            h6("For this overview tab, the data has been broken down by age and sex for patient daycase 
               activity in the 14 scottish healthboards"),
            h6("source of dataset for this tab:",
               tags$a("Public Health Scotland",
                      href = "https://www.opendata.nhs.scot/dataset/annual-inpatient-and-daycase-activity/resource/a9d6e25d-ee49-4868-8bec-6205998b93b9"))
            
          )
        ),
        fluidRow(
          box(
            width = 4,
            selectInput("year", label = h4("Select Year"), 
                        choices = unique(general_age_sex$financial_year), 
                        selected = "2019/20")
          ),
          
          box(
            width = 8,
            plotOutput("age_sex_plot")
          )
        ),
        
        fluidRow(
          box(
            width = 4, 
            radioButtons("sex", label = h4("Select Gender"),
                         choices = list("Female" = "Female", "Male" = "Male", 
                                        "All" = "All Sexes"), 
                         selected = "All Sexes"),
            selectInput("age", label = h4("Select Age Group"), 
                        choices = unique(general_age_sex$age), 
                        selected = "All Ages")
          ),
          
          box(
            width = 8, 
            plotOutput("agesex_admission_plot")
          )
        ),
        
        fluidRow(
          box(
            title = "Stays and length of stays in Scottish hospitals",
            width = 4,
            
            #####
            selectInput("year",
                        "Select Year",
                        choices = unique(department_data$financial_year)),
            
            selectInput("department",
                        "Select Department",
                        choices = unique(department_data$department)),
            
            actionButton("update", "Thank you NHS")
            #####
          ),
          
          box(
            width = 8,
            
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
            width = 6,
            h3("About"),
            h6("This map and graph show the count and ratio (per 100,000 people) of
               some of the most common conditions caused by abuse of alcohol throughout Scotland"),
            h6("source of dataset for this tab:",
               tags$a("Scottish Government",
                      href = "https://statistics.gov.scot/resource?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2Falcohol-related-hospital-statistics"))
            
          )
        ),
        
        fluidRow(
          
          column(width = 3,
            box(
              title = "Select Year",
              width = NULL
            ),
            box(
              title = "Select Metric",
              width = NULL
            ),
            box(
              title = "Select Ratio or Count",
              width = NULL
            )
          ),
          
          column(width = 9,
            box(
              title = "Map",
              width = NULL
            ),
            box(
              title = "graph/table",
              width = NULL
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
            width = 6,
            h3("About"),
            h6("The graph and table on this tab show a comparison of summarised groups of medical conditions 
            caused by the abuse of alcohol. Comparisons can be drawn based on NHS healthboards"),
            h6("source of dataset for this tab:",
               tags$a("Scottish Government",
                      href = "https://statistics.gov.scot/resource?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2Falcohol-related-hospital-statistics"))
            
          )
        ),
        
        fluidRow(
          
          column(width = 3,
                 box(
                   width = NULL,
                   selectInput("date_code",
                   "Which year?",
                   choices = unique(alcohol_table$date_code)
                   )
                 ),
                 box(
                   width = NULL,
                   radioButtons("alcohol_condition",
                   "Condition type",
                   choices = unique(alcohol_table$alcohol_condition)
                   )
                 ),
                 box(
                   width = NULL,
                   radioButtons("type_of_hospital",
                   "Type of hospital",
                   choices = unique(alcohol_table$type_of_hospital)
                   )
                 )
                 
          ),
          
          column(width = 9,
                 box(
                   title = "bar graph",
                   width = NULL,
                   plotOutput("histogram")
                 ),
                 box(
                   title = "table",
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