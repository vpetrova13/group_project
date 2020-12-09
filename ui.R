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
            title = "selection 3",
            width = 4
          ),
          
          box(
            title = "graph 3",
            width = 8
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
          
          column(width = 6,
            box(
              title = "Map",
              width = NULL
            ),
            box(
              title = "graph/table",
              width = NULL
            )
          ),
          
          column(width = 3,
            box(
              title = "text description",
              width = NULL
            )
          )
        )
      ),
      # Third tab content <- table and graph
      tabItem(
        tabName = "regional",
        h2("tab content"),
        
        fluidRow(
          
          column(width = 3,
                 box(
                   title = "selection 1",
                   width = NULL
                 ),
                 box(
                   title = "selection 2",
                   width = NULL
                 )
          ),
          
          column(width = 6,
                 box(
                   title = "bar graph",
                   width = NULL
                 ),
                 box(
                   title = "table",
                   width = NULL
                 )
          ),
          
          column(width = 3,
                 box(
                   title = "text description",
                   width = NULL
                 )
          )
        )
      )
    )
  )
)