# 01-kmeans-app

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

library(shiny)

ui <- fluidPage(
  headerPanel('Iris k-means clustering'),
  ###
  sidebarPanel(
    selectInput(
      "plotType", "Plot Type",
      c(Scatter = "scatter",
        Histogram = "hist")),
    
    # Only show this panel if the plot type is a histogram
    conditionalPanel(
      condition = "input.plotType == 'hist'",
      selectInput(
        "breaks", "Breaks",
        c("Sturges",
          "Scott",
          "Freedman-Diaconis",
          "[Custom]" = "custom")),
      
      # Only show this panel if Custom is selected
      conditionalPanel(
        condition = "input.breaks == 'custom'",
        sliderInput("breakCount", "Break Count", min=1, max=1000, value=10)
      )
    )
  ),
  selectInput(
    "q", "question",
    c("a",
      "b",
      "c",
      "none of the above" = "d")),
  conditionalPanel(condition = "input.q == 'b'",
                   actionButton("other button", "Condition met!")
  ),
  ###
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris),
                selected = names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

server <- function(input, output) {

  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })

  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })

  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })

}

shinyApp(ui = ui, server = server)
