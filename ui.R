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
      theme = "purple_gradient"
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
          box(
            title = "Select Year",
            width = 3
          ),
          box(
            title = "Map",
            width = 6
          ),
          box(
            title = "Description of Data",
            width = 3
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