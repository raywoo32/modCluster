# server.R

#  modCluster::runExample()
library(shiny)
library(datasets)
load("../../../data/exampleEdge.Rda")
load("../../../data/exampleVert.Rda")

#' Define server logic required to summarize and view the selected dataset
#'
#' @import shiny
shinyServer(function(input, output) {
  # Adapted from: https://shiny.rstudio.com/articles/tabsets.html
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "verticies" = vert,
           "edges" = edges)
  })
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = 20)
  })
  # make plot output
  output$plot <- renderPlot({
    geneFlag <- input$geneFlag

    modCluster(edges, vert, geneFlag)
  })
})
