# ui.R

library(shiny)

#' Define UI for dataset viewer application
#'
#' @import shiny
shinyUI(pageWithSidebar(
  # Adapted from: https://shiny.rstudio.com/articles/tabsets.html
  # Application title
  headerPanel("Explore modCluster"),

  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    selectInput("geneFlag", "Choose to display gene name",
                choices = c(TRUE, FALSE)),
    selectInput("dataset", "View data input examples",
                choices = c("verticies", "edges")),

  ),

  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel("View Example Output", plotOutput("plot")),
                tabPanel("View Example Inputs", tableOutput("view"))
    )
  )
))

