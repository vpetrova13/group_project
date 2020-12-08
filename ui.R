# UI 
ui <- dashboardPage(
  dashboardHeader(
    title = "Health Scotland",
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
      menuItem("Regional Overview", tabName = "regional overview", icon = icon("signal"))
    )
  ),
  dashboardBody(
    # Changing theme <- this needs to go inside the dashboardBody
    shinyDashboardThemes(
      theme = "grey_dark"
    ),
    tabItems(
      # First tab content <- general overview
      tabItem(
        tabName = "overview",
        h2("tab content"),
        fluidRow(
          box(
            title = "graph",
            width = 4
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
        tabName = "regional overview",
        h2("tab content")
      )
    )
  )
)