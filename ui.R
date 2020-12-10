# UI 
ui <- dashboardPage(
  dashboardHeader(
    title = h3("Health Scotland"),
    dropdownMenu(type = "notifications",
                 notificationItem(
                   text = "information",
                   icon = icon("alert")
                 )
    )
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
        h2("tab content"),
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
                        "Select Year",
                        choices = unique(department_data$financial_year)),
            
            selectInput("department",
                        "Select Department",
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
        h2("tab content"),
        
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
              actionButton("update_map", "Show map & data")
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
        h2("Healthboard specific data"),

        
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