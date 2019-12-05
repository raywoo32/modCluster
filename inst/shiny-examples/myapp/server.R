# server.R

#  modCluster::runExample()
library(shiny)
library(datasets)


#' Define server logic required to summarize and view the selected dataset
#'
#' @import shiny
shinyServer(function(input, output) {
  # Adapted from: https://shiny.rstudio.com/articles/tabsets.html
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "verticies" = edgesData,
           "edges" = verticiesData)
  })
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = 20)
  })
  # make plot output
  output$plot <- renderPlot({
    communityFlag <- input$communityFlag

    clusterByModule(edgesData, verticiesData, displayCommunity=communityFlag)
  })
})
