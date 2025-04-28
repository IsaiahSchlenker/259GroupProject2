library(shiny)
library(tidyverse)

# Load data

load("C:/Users/bluet/Downloads/data-music.RData") # Enter your file location here, be sure to use / and not \
musicData <- as.data.frame(data_music)

numericVars <- names(musicData)[sapply(musicData, is.numeric)]

# User interface code

ui <- fluidPage(
  titlePanel("Shiny Music Data Explorer"),
  
  sidebarPanel(
    selectInput("xVar", "Choose X Variable", choices = numericVars),
    selectInput("yVar", "Choose Y Variable", choices = numericVars, selected = numericVars[[2]]),
  ),
  
  mainPanel(
    plotOutput("plot1")
  )
)

# Server code

server <- function(input, output) {
  
  output$plot1 <- renderPlot({
    plot <- ggplot(musicData, aes_string(x = input$xVar, y = input$yVar))
    
    plot + 
      geom_point(size = 2, alpha = 0.7) +
      theme_minimal() +
      labs(title = paste("Scatterplot of", input$yVar, "vs", input$xVar))
  })
}

# Run app

shinyApp(ui, server)
